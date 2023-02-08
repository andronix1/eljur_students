import 'package:eljur_students/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:eljur_students/core/usecase.dart';
import 'package:eljur_students/features/schedule/domain/repositories/schedule_repository.dart';

import '../entities/schedule_day.dart';

class GetScheduleUseCaseParams {}

class GetScheduleUseCase
    extends UseCase<List<ScheduleDay>, GetScheduleUseCaseParams> {
  final ScheduleRepository repository;

  GetScheduleUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ScheduleDay>>> call(
          GetScheduleUseCaseParams params) =>
      repository.getSchedule();
}
