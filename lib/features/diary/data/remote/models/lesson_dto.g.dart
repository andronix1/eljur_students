// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonDto _$LessonDtoFromJson(Map<String, dynamic> json) => LessonDto(
      name: json['name'] as String,
      number: json['num'] as String,
      files: (json['files'] as List<dynamic>?)
              ?.map((e) =>
                  HomeworkFileInfoDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      room: json['room'] as String,
      teacher: json['teacher'] as String,
      startsAt: DayTimeDto.fromJson(json['starttime'] as String),
      endsAt: DayTimeDto.fromJson(json['endtime'] as String),
      assessments: (json['assessments'] as List<dynamic>?)
              ?.map((e) => AssessmentDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      homework: (json['homework'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k, HomeworkTaskDto.fromJson(e as Map<String, dynamic>)),
          ) ??
          {},
    );
