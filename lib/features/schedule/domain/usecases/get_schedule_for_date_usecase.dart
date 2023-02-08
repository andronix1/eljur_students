import 'package:eljur_students/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:eljur_students/core/usecase.dart';
import 'package:eljur_students/features/schedule/domain/repositories/schedule_repository.dart';

import '../entities/schedule_day.dart';

class GetScheduleForDateUseCaseParams {
  final DateTime day;

  GetScheduleForDateUseCaseParams({required this.day});
}

class GetScheduleForDateUseCase
    extends UseCase<ScheduleDay?, GetScheduleForDateUseCaseParams> {
  final ScheduleRepository repository;

  GetScheduleForDateUseCase({required this.repository});

  @override
  Future<Either<Failure, ScheduleDay?>> call(
          GetScheduleForDateUseCaseParams params) =>
      repository.getScheduleForDate(params.day);
}
