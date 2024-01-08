import 'package:eljur_students/features/diary/data/local/models/schedule_day_dto.dart';
import 'package:eljur_students/features/diary/domain/models/schedule.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class SembastScheduleDto {
  final Map<DateTime, SembastScheduleDayDto> days;

  SembastScheduleDto({required this.days});

  factory SembastScheduleDto.fromJson(Map<String, dynamic> json) => _$SembastScheduleDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SembastScheduleDtoToJson(this);

  factory SembastScheduleDto.fromSchedule(Schedule schedule) => SembastScheduleDto(days: schedule.days.map((k, v) => MapEntry(k, SembastScheduleDayDto.fromScheduleDay(v))));
  Schedule toSchedule() => Schedule(days: days
    .map((k, v) => MapEntry(k, v.toScheduleDay())));
}