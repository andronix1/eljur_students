class TokenInfo {
  final String token;
  final DateTime _expires;

  TokenInfo(this.token, this._expires);

  bool expired() => DateTime.now().isAfter(_expires);
}

class AuthInfo {
  final String username;
  final String password;

  AuthInfo(this.username, this.password);
}

class Account {
  final AuthInfo authInfo;
  final TokenInfo tokenInfo;

  Account(this.authInfo, this.tokenInfo);
}
