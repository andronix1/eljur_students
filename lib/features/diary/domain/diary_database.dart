import 'package:eljur_students/core/failure/failure.dart';
import 'package:eljur_students/features/diary/domain/models/schedule.dart';

abstract class DiaryDatabase {
  Future<Failable<Schedule>> getSchedule();
  Future<Failable<void>> setSchedule(Schedule schedule);
}