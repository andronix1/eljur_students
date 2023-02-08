part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleState {}

class ScheduleInitialState extends ScheduleState {}

class ScheduleLoadingState extends ScheduleState {}

class ScheduleLoadedState extends ScheduleState {
  final List<ScheduleDay> days;

  ScheduleLoadedState({required this.days});
}

class ScheduleLoadErrorState extends ScheduleState {}
