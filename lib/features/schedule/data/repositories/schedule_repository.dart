import 'package:eljur_students/core/errors/exceptions/cache_exception.dart';
import 'package:eljur_students/core/errors/exceptions/server_exception.dart';
import 'package:eljur_students/core/errors/failures/cache_failure.dart';
import 'package:eljur_students/features/schedule/data/datasources/schedule_local_datasource.dart';
import 'package:eljur_students/features/schedule/data/datasources/schedule_remote_datasource.dart';
import 'package:eljur_students/features/schedule/domain/entities/schedule_day.dart';
import 'package:eljur_students/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:eljur_students/features/schedule/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleLocalDataSource localDataSource;
  final ScheduleRemoteDataSource remoteDataSource;

  ScheduleRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ScheduleDay>>> getSchedule() async {
    DateTime now = DateTime.now();
    try {
      var schedule = await remoteDataSource.getSchedule(
          now.add(Duration(days: -now.weekday)),
          now.add(Duration(days: 7 - now.weekday)));
      await localDataSource.cacheSchedule(schedule);
      return Right(schedule);
    } on ServerException {
      try {
        return Right(await localDataSource.getSchedule());
      } on CacheException {
        return Left(CacheFailure());
      }
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, ScheduleDay?>> getScheduleForDate(
      DateTime date) async {
    try {
      var days = await remoteDataSource.getSchedule(date, date);
      return days.isEmpty ? const Right(null) : Right(days.first);
    } on ServerException {
      try {
        var days = await localDataSource.getSchedule();
        var dayId = days.indexWhere((element) => element.dateTime == date);
        return dayId == -1 ? const Right(null) : Right(days[dayId]);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
