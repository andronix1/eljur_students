// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_day_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleDayDto _$ScheduleDayDtoFromJson(Map<String, dynamic> json) =>
    ScheduleDayDto(
      lessons: ScheduleDayDto._lessonsFromJson(json['items']),
      day: DateTime.parse(json['name'] as String),
    );
