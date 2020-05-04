import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/models/models.dart';

class BaseService {

  final String _baseURL = GlobalConfiguration().getString("apiUrl");

  Future get(String segment) async {
    return this.fetch(segment, "GET");
  }

  Future post(String segment, dynamic body) async {
    return this.fetch(segment, "POST", body);
  }

  Future put(String segment, dynamic body) async {
    return this.fetch(segment, "PUT", body);
  }

  Future patch(String segment, dynamic body) async {
    return this.fetch(segment, "PATCH", body);
  }

  Future delete(String segment) async {
    return this.fetch(segment, "DELETE");
  }

  Future fetch(String segment, String methodToExecute, [dynamic body]) async {
    final headers = await this.headers();
    final String url = "$_baseURL/$segment";
    print(url);
    http.Response response;

    switch (methodToExecute.toUpperCase()) {
      case "GET":
        response = await http.get(url, headers: headers);
        break;
      case "POST":
        response =
            await http.post(url, headers: headers, body: json.encode(body));
        break;
      case "PATCH":
        response =
            await http.patch(url, headers: headers, body: json.encode(body));
        break;
      case "PUT":
        response =
            await http.put(url, headers: headers, body: json.encode(body));
        break;
      case "DELETE":
        response = await http.delete(url, headers: headers);
        break;
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body.isNotEmpty ? json.decode(response.body) : {};
    } else if (response.statusCode == 401 &&
        response.headers["token-expired"] == "true") {
      await this.refreshToken();
      this.fetch(segment, methodToExecute, body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<Map<String, String>> headers() async {
    final String token = await CustomerSharedPrefernces.getValue("token");
    return {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
  }

  Future<bool> refreshToken() async {
    http.Response response = await http.post(
      "$_baseURL/refreshToken",
      headers: await this.headers(),
      body: json.encode(
        {
          "token": await CustomerSharedPrefernces.getValue("token"),
          "refreshToken":
              await CustomerSharedPrefernces.getValue("refreshToken")
        },
      ),
    );

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var responseTranslated = new Tokens.fromDynamic(body);
      await CustomerSharedPrefernces.setValue(
          "token", responseTranslated.token);
      await CustomerSharedPrefernces.setValue(
          "refreshToken", responseTranslated.refreshToken);
      return true;
    } else {
      await CustomerSharedPrefernces.removeValue("token");
      await CustomerSharedPrefernces.removeValue("refreshToken");
      return false;
    }
  }
}
