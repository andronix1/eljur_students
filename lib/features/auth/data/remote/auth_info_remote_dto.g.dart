// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_info_remote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthInfoRemoteDto _$AuthInfoRemoteDtoFromJson(Map<String, dynamic> json) =>
    AuthInfoRemoteDto(
      token: json['token'] as String,
      expires: DateTime.parse(json['expires'] as String),
    );

Map<String, dynamic> _$AuthInfoRemoteDtoToJson(AuthInfoRemoteDto instance) =>
    <String, dynamic>{
      'token': instance.token,
      'expires': instance.expires.toIso8601String(),
    };
