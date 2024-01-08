import 'package:eljur_students/features/diary/domain/models/day_time.dart';
import 'package:json_annotation/json_annotation.dart';

part 'day_time_dto.g.dart';

@JsonSerializable()
class SembastDayTimeDto {
  final int hour, minute;

  SembastDayTimeDto({required this.hour, required this.minute});

  factory SembastDayTimeDto.fromJson(Map<String, dynamic> json) => _$SembastDayTimeDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SembastDayTimeDtoToJson(this);

  factory SembastDayTimeDto.fromDayTime(DayTime dayTime) => SembastDayTimeDto(hour: dayTime.hour, minute: dayTime.minute);
  DayTime toDayTime() => DayTime(hour: hour, minute: minute);
}