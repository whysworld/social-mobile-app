class Tokens {
  final String token;
  final String refreshToken;

  Tokens(this.token, this.refreshToken);

  Tokens.fromDynamic(Map<String, dynamic> json)
      : token = json['token'],
        refreshToken = json['refreshToken'];
}
