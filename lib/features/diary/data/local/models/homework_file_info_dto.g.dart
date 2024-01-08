// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homework_file_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SembastHomeworkFileInfoDto _$SembastHomeworkFileInfoDtoFromJson(
        Map<String, dynamic> json) =>
    SembastHomeworkFileInfoDto(
      destination: Uri.parse(json['destination'] as String),
      value: json['value'] as String,
    );

Map<String, dynamic> _$SembastHomeworkFileInfoDtoToJson(
        SembastHomeworkFileInfoDto instance) =>
    <String, dynamic>{
      'value': instance.value,
      'destination': instance.destination.toString(),
    };
