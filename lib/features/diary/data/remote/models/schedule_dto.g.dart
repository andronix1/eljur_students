// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleDto _$ScheduleDtoFromJson(Map<String, dynamic> json) => ScheduleDto(
      days: (json['days'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, ScheduleDayDto.fromJson(e as Map<String, dynamic>)),
      ),
    );
