import 'package:eljur_students/features/diary/domain/diary_repository.dart';
import 'package:eljur_students/features/diary/domain/models/schedule_day.dart';
import 'package:eljur_students/features/diary/presentation/screens/diary_view/diary_view_state.dart';
import 'package:eljur_students/features/diary/presentation/screens/diary_view/schedule_day_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiaryViewCubit extends Cubit<DiaryViewState> {
  final DiaryRepository repository;
  final Map<int, ScheduleDayState> _loadedSchedule = {};

  final DateTime _currentDate = DateTime.now()
      .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);

  int _currentDateOffset = 0;

  DiaryViewCubit({required this.repository}) : super(DiaryViewLoading()) {
    loadDefaultDiary();
  }

  DateTime _getDateWithOffset(int offset) =>
      _currentDate.add(Duration(days: offset));
  DateTime _getSelectedDate() => _getDateWithOffset(_currentDateOffset);
  int _getOffset(DateTime date) => date.difference(_currentDate).inDays;

  void nextDay() {
    _currentDateOffset++;
    _onDayOpened();
  }

  void previousDay() {
    _currentDateOffset--;
    _onDayOpened();
  }

  void _onDayOpened() {
    _loadDay(_currentDateOffset);
    _loadDay(_currentDateOffset - 1);
    _loadDay(_currentDateOffset + 1);
    _onDayUpdated(_currentDateOffset);
  }

  void _onDayUpdated(int offset) {
    if (offset == _currentDateOffset) {
      emit(DiaryViewLoaded(
          currentDayOffset: offset,
          currentPage: _loadedSchedule[_currentDateOffset]!,
          nextPage: _loadedSchedule[_currentDateOffset + 1]!,
          previousPage: _loadedSchedule[_currentDateOffset - 1]!));
    }
  }

  void _loadDay(int offset) {
    if (_loadedSchedule[offset] != null &&
        (offset != _currentDateOffset ||
            _loadedSchedule[offset] is! ScheduleDayLoadingFailure)) return;
    var date = _getDateWithOffset(offset);
    _loadedSchedule[offset] = ScheduleDayLoading(selectedDate: date);
    repository
        .loadScheduleForDay(_getDateWithOffset(offset))
        .then((result) => result.match((daySchedule) {
              _loadedSchedule[offset] = ScheduleDayLoaded(
                  selectedDate: date, scheduleDay: daySchedule);
            }, (failure) {
              _loadedSchedule[offset] = ScheduleDayLoadingFailure(
                  selectedDate: date, failure: failure);
            }))
        .then((_) => _onDayUpdated(offset));
  }

  Future loadDefaultDiary() async {
    emit(DiaryViewLoading());
    await repository.getDefaultDiary().then((value) => value.match((result) {
          for (DateTime i = result.days.keys.first;
              !i.isAfter(result.days.keys.last);
              i = i.add(const Duration(days: 1))) {
            _loadedSchedule.addAll({
              _getOffset(i): ScheduleDayLoaded(
                  selectedDate: i,
                  scheduleDay: result.days[i] ?? ScheduleVacationDay())
            });
          }
        }, (failure) {
          emit(DiaryViewFailed(failure: failure));
        }));
    _onDayOpened();
  }
}
