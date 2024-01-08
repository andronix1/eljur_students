// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_sembast_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSembastDto _$UserSembastDtoFromJson(Map<String, dynamic> json) =>
    UserSembastDto(
      token: json['token'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      middleName: json['middleName'] as String,
    );

Map<String, dynamic> _$UserSembastDtoToJson(UserSembastDto instance) =>
    <String, dynamic>{
      'token': instance.token,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
    };
