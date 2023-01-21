import 'package:eljur_students/features/eljur_auth/domain/entities/account_entity.dart';

class UserInfoModel extends UserInfo {
  UserInfoModel(
      {required super.id,
      required super.firstName,
      required super.middleName,
      required super.lastName});

  factory UserInfoModel.fromApiJson(Map<String, dynamic> json) => UserInfoModel(
      id: json['id'],
      firstName: json['firstName'.toLowerCase()],
      middleName: json['middleName'.toLowerCase()],
      lastName: json['lastName'.toLowerCase()]);

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
      id: json['id'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName
      };
}

class TokenInfoModel extends TokenInfo {
  TokenInfoModel({required super.token, required super.expires});

  factory TokenInfoModel.fromJson(Map<String, dynamic> json) => TokenInfoModel(
      token: json['token'], expires: DateTime.parse(json['expires']));

  Map<String, dynamic> toJson() => {
        'expires': expires.toIso8601String(),
        'token': token,
      };
}

class AuthInfoModel extends AuthInfo {
  AuthInfoModel({required super.username, required super.password});

  factory AuthInfoModel.fromJson(Map<String, dynamic> json) =>
      AuthInfoModel(username: json['username'], password: json['password']);

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}

class AccountModel extends AccountEntity {
  AccountModel(
      {required super.authInfo,
      required super.tokenInfo,
      required super.userInfo});

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
      authInfo: AuthInfoModel.fromJson(json['authInfo']),
      tokenInfo: TokenInfoModel.fromJson(json['tokenInfo']),
      userInfo: UserInfoModel.fromJson(json['userInfo']));

  Map<String, dynamic> toJson() => {
        'authInfo': AuthInfoModel(
                password: authInfo.password, username: authInfo.username)
            .toJson(),
        'tokenInfo':
            TokenInfoModel(token: tokenInfo.token, expires: tokenInfo.expires)
                .toJson(),
        'userInfo': UserInfoModel(
                id: userInfo.id,
                firstName: userInfo.firstName,
                middleName: userInfo.middleName,
                lastName: userInfo.lastName)
            .toJson(),
      };
}
