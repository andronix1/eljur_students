import 'package:eljur_students/core/failure/failure.dart';
import 'package:eljur_students/features/diary/presentation/screens/diary_view/schedule_day_state.dart';

sealed class DiaryViewState {}

class DiaryViewLoading extends DiaryViewState {}

class DiaryViewFailed extends DiaryViewState {
  final Failure failure;

  DiaryViewFailed({required this.failure});
}

class DiaryViewLoaded extends DiaryViewState {
  final int currentDayOffset;
  final ScheduleDayState currentPage, nextPage, previousPage;

  DiaryViewLoaded(
      {required this.currentDayOffset,
      required this.currentPage,
      required this.nextPage,
      required this.previousPage});
}
