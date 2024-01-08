import 'package:eljur_students/core/failure/failure.dart';
import 'package:eljur_students/features/diary/domain/models/schedule.dart';

abstract class DiaryRemote {
  Future<Failable<Schedule>> getDiary(DateTime after, DateTime before);
}