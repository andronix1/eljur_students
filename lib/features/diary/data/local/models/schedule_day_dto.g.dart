// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_day_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SembastScheduleDayDto _$SembastScheduleDayDtoFromJson(
        Map<String, dynamic> json) =>
    SembastScheduleDayDto(
      lessons: (json['lessons'] as List<dynamic>)
          .map((e) => SembastLessonDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      isVacation: json['isVacation'] as bool,
    );

Map<String, dynamic> _$SembastScheduleDayDtoToJson(
        SembastScheduleDayDto instance) =>
    <String, dynamic>{
      'isVacation': instance.isVacation,
      'lessons': instance.lessons.map((e) => e.toJson()).toList(),
    };
