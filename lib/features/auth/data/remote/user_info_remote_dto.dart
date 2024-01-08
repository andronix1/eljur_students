import 'package:eljur_students/features/auth/domain/models/user_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_info_remote_dto.g.dart';

@JsonSerializable()
class UserInfoRemoteDto {
  final String id;

  @JsonKey(name: 'firstname')
  final String firstName;
  @JsonKey(name: 'lastname')
  final String middleName;
  @JsonKey(name: 'middlename')
  final String lastName;

  UserInfoRemoteDto(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.middleName});

  factory UserInfoRemoteDto.fromJson(Map<String, dynamic> json) =>
      _$UserInfoRemoteDtoFromJson(json);

  UserInfo toUserInfo() {
    return UserInfo(
      userId: int.parse(id),
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
    );
  }
}
