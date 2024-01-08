import 'package:eljur_students/features/diary/domain/models/lesson.dart';

sealed class ScheduleDay {}

class ScheduleWorkDay extends ScheduleDay {
  final List<Lesson> lessons;

  ScheduleWorkDay({required this.lessons});
}

class ScheduleVacationDay extends ScheduleDay {}