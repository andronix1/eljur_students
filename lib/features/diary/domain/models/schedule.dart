import 'package:eljur_students/features/diary/domain/models/schedule_day.dart';

class Schedule {
  final Map<DateTime, ScheduleDay> days;

  Schedule({required this.days});
}