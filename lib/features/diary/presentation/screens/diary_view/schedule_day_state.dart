import 'package:eljur_students/core/failure/failure.dart';
import 'package:eljur_students/features/diary/domain/models/schedule_day.dart';

sealed class ScheduleDayState {
  final DateTime selectedDate;

  ScheduleDayState({required this.selectedDate});
}

class ScheduleDayLoading extends ScheduleDayState {
  ScheduleDayLoading({required super.selectedDate});
}

class ScheduleDayLoadingFailure extends ScheduleDayState {
  final Failure failure;

  ScheduleDayLoadingFailure(
      {required this.failure, required super.selectedDate});
}

class ScheduleDayLoaded extends ScheduleDayState {
  final ScheduleDay scheduleDay;

  ScheduleDayLoaded({required this.scheduleDay, required super.selectedDate});
}
