import 'package:eljur_students/core/failure/failure.dart';
import 'package:eljur_students/features/diary/domain/dary_remote.dart';
import 'package:eljur_students/features/diary/domain/diary_database.dart';
import 'package:eljur_students/features/diary/domain/models/schedule.dart';
import 'package:eljur_students/features/diary/domain/models/schedule_day.dart';
import 'package:oxidized/oxidized.dart';

class DiaryRepository {
  final DiaryDatabase database;
  final DiaryRemote remote;

  DiaryRepository({required this.database, required this.remote});

  Future<Failable<Schedule>> getDefaultDiary(int daysBefore, int daysAfter) => remote
      .getDiary(DateTime.now().add(Duration(days: -daysBefore)),
          DateTime.now().add(Duration(days: daysAfter)))
      .andThenAsync((schedule) async =>
          (await database.setSchedule(schedule)).map((_) => schedule))
      .orElseAsync((failure) => database.getSchedule());
  Future<Failable<ScheduleDay>> loadScheduleForDay(DateTime day) => remote
      .getDiary(day, day)
      .andThen((schedule) => Ok(schedule.days[day] ?? ScheduleVacationDay()));
}
