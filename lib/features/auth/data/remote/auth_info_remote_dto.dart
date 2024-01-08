import 'package:eljur_students/features/auth/domain/models/auth_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_info_remote_dto.g.dart';

@JsonSerializable()
class AuthInfoRemoteDto {
  final String token;
  final DateTime expires;

  AuthInfoRemoteDto({required this.token, required this.expires});

  factory AuthInfoRemoteDto.fromJson(Map<String, dynamic> json) =>
      _$AuthInfoRemoteDtoFromJson(json);

  AuthInfo toAuthInfo() {
    return AuthInfo(token: token, expiresAt: expires);
  }
}
