import 'package:eljur_students/features/diary/domain/models/day_time.dart';

class DayTimeDto {
  final int hour, minute;

  DayTimeDto({required this.hour, required this.minute});

  factory DayTimeDto.fromJson(String json) {
    var parsed = json.split(':').map((e) => int.parse(e)).toList();
    return DayTimeDto(hour: parsed[0], minute: parsed[1]);
  }

  DayTime toDayTime() => DayTime(hour: hour, minute: minute);
}