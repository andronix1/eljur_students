class UserInfo {
  final int id;
  final String firstName, middleName, lastName;

  UserInfo(this.id,
      {required this.firstName,
      required this.middleName,
      required this.lastName});
}

class TokenInfo {
  final String token;
  final DateTime expires;

  TokenInfo({required this.token, required this.expires});
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
