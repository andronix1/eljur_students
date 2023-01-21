class UserInfo {
  final String id, firstName, middleName, lastName;

  UserInfo(
      {required this.id,
      required this.firstName,
      required this.middleName,
      required this.lastName});
}

class TokenInfo {
  final String token;
  final DateTime expires;

  TokenInfo({required this.token, required this.expires});

  bool get expired => DateTime.now().isAfter(expires);
}

class AuthInfo {
  final String username, password;

  AuthInfo({required this.username, required this.password});
}

class AccountEntity {
  final UserInfo userInfo;
  final AuthInfo authInfo;
  final TokenInfo tokenInfo;

  AccountEntity(
      {required this.authInfo,
      required this.tokenInfo,
      required this.userInfo});
}
