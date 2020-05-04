import 'package:tracksite/models/models.dart';
import 'package:tracksite/services/base.dart';

class LoginService extends BaseService {
  Future<Tokens> signInWithUsernameAndPassword({
    String username,
    String password,
  }) async {
    var response = await this.post(
      'v2/users/login',
      {"username": username, "password": password},
    );

    return new Tokens.fromDynamic(response);
  }
} 
