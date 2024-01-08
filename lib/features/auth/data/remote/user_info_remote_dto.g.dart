// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_remote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoRemoteDto _$UserInfoRemoteDtoFromJson(Map<String, dynamic> json) =>
    UserInfoRemoteDto(
      id: json['id'] as String,
      firstName: json['firstname'] as String,
      lastName: json['middlename'] as String,
      middleName: json['lastname'] as String,
    );

Map<String, dynamic> _$UserInfoRemoteDtoToJson(UserInfoRemoteDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstName,
      'lastname': instance.middleName,
      'middlename': instance.lastName,
    };
