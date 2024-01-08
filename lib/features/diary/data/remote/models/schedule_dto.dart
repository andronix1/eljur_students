import 'package:eljur_students/features/diary/data/remote/models/schedule_day_dto.dart';
import 'package:eljur_students/features/diary/domain/models/schedule.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_dto.g.dart';

@JsonSerializable(createToJson: false)
class ScheduleDto {
  @JsonKey(name: 'days')
  final Map<String, ScheduleDayDto> days;

  ScheduleDto({required this.days});

  factory ScheduleDto.fromJson(Map<String, dynamic> json) => _$ScheduleDtoFromJson(json);

  Schedule toSchedule() => Schedule(days: days.map((_, v) => MapEntry(v.day, v.toScheduleDay())));
}