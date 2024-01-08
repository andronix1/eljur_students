// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SembastLessonDto _$SembastLessonDtoFromJson(Map<String, dynamic> json) =>
    SembastLessonDto(
      number: json['number'] as int,
      name: json['name'] as String,
      room: json['room'] as String,
      teacher: json['teacher'] as String,
      startsAt:
          SembastDayTimeDto.fromJson(json['startsAt'] as Map<String, dynamic>),
      endsAt:
          SembastDayTimeDto.fromJson(json['endsAt'] as Map<String, dynamic>),
      assessments: (json['assessments'] as List<dynamic>)
          .map((e) => SembastAssessmentDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      homework: (json['homework'] as List<dynamic>)
          .map(
              (e) => SembastHomeworkTaskDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      individualHomework: (json['individualHomework'] as List<dynamic>)
          .map(
              (e) => SembastHomeworkTaskDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SembastLessonDtoToJson(SembastLessonDto instance) =>
    <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
      'room': instance.room,
      'teacher': instance.teacher,
      'startsAt': instance.startsAt.toJson(),
      'endsAt': instance.endsAt.toJson(),
      'homework': instance.homework.map((e) => e.toJson()).toList(),
      'individualHomework':
          instance.individualHomework.map((e) => e.toJson()).toList(),
      'assessments': instance.assessments.map((e) => e.toJson()).toList(),
    };
