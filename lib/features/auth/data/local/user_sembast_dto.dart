import 'package:eljur_students/features/auth/domain/models/auth_info.dart';
import 'package:eljur_students/features/auth/domain/models/user.dart';
import 'package:eljur_students/features/auth/domain/models/user_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_sembast_dto.g.dart';

@JsonSerializable()
class UserSembastDto {
  final String token;
  final DateTime expiresAt;

  final String firstName, middleName, lastName;

  UserSembastDto(
      {required this.token,
      required this.expiresAt,
      required this.firstName,
      required this.lastName,
      required this.middleName});

  factory UserSembastDto.fromUser(User user) {
    return UserSembastDto(
        token: user.authInfo.token,
        expiresAt: user.authInfo.expiresAt,
        firstName: user.userInfo.firstName,
        lastName: user.userInfo.lastName,
        middleName: user.userInfo.middleName);
  }

  User toUser(UserId userId) {
    return User(
        authInfo: AuthInfo(
          token: token,
          expiresAt: expiresAt,
        ),
        userInfo: UserInfo(
          userId: userId,
          firstName: firstName,
          middleName: middleName,
          lastName: lastName,
        ));
  }

  factory UserSembastDto.fromJson(Map<String, dynamic> json) =>
      _$UserSembastDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserSembastDtoToJson(this);
}
