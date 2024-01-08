// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homework_task_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SembastHomeworkTaskDto _$SembastHomeworkTaskDtoFromJson(
        Map<String, dynamic> json) =>
    SembastHomeworkTaskDto(
      text: json['text'] as String,
      files: (json['files'] as List<dynamic>)
          .map((e) =>
              SembastHomeworkFileInfoDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SembastHomeworkTaskDtoToJson(
        SembastHomeworkTaskDto instance) =>
    <String, dynamic>{
      'text': instance.text,
      'files': instance.files.map((e) => e.toJson()).toList(),
    };
