import 'package:eljur_students/features/diary/domain/models/assessment.dart';
import 'package:eljur_students/features/diary/domain/models/day_time.dart';
import 'package:eljur_students/features/diary/domain/models/homework_task.dart';

class Lesson {
  final int number;
  final String name, room, teacher;
  final DayTime startsAt, endsAt;
  final List<HomeworkTask> homework, individualHomework;
  final List<Assessment> assessments;

  Lesson(
      {required this.number,
      required this.name,
      required this.room,
      required this.teacher,
      required this.startsAt,
      required this.endsAt,
      required this.assessments,
      required this.homework,
      required this.individualHomework});
}
