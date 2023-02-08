import 'package:eljur_students/core/errors/failures/cache_failure.dart';
import 'package:eljur_students/core/errors/failures/server_failure.dart';
import 'package:eljur_students/features/schedule/domain/entities/schedule_day.dart';
import 'package:eljur_students/features/schedule/domain/usecases/get_schedule_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final GetScheduleUseCase getSchedule;

  ScheduleBloc({required this.getSchedule}) : super(ScheduleInitialState()) {
    on<ScheduleEvent>((event, emit) async {
      if (event is ReloadScheduleEvent) {
        emit(ScheduleLoadingState());
        (await getSchedule(GetScheduleUseCaseParams())).fold((l) {
          if (l is ServerFailure) {
            emit(ScheduleLoadErrorState());
          } else if (l is CacheFailure) {
            emit(ScheduleLoadErrorState());
          }
        }, (r) => emit(ScheduleLoadedState(days: r)));
      }
    });
  }
}
