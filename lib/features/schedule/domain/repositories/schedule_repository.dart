import 'package:dartz/dartz.dart';
import 'package:eljur_students/core/errors/failure.dart';
import 'package:eljur_students/features/schedule/domain/entities/schedule_day.dart';

abstract class ScheduleRepository {
  Future<Either<Failure, List<ScheduleDay>>> getSchedule();
  Future<Either<Failure, ScheduleDay?>> getScheduleForDate(DateTime date);
}
