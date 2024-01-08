// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SembastScheduleDto _$SembastScheduleDtoFromJson(Map<String, dynamic> json) =>
    SembastScheduleDto(
      days: (json['days'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(DateTime.parse(k),
            SembastScheduleDayDto.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$SembastScheduleDtoToJson(SembastScheduleDto instance) =>
    <String, dynamic>{
      'days': instance.days
          .map((k, e) => MapEntry(k.toIso8601String(), e.toJson())),
    };
