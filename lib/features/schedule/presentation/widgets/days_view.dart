import 'package:eljur_students/dependency_injection.dart';
import 'package:eljur_students/features/schedule/domain/entities/schedule_day.dart';
import 'package:eljur_students/features/schedule/domain/usecases/get_schedule_for_date_usecase.dart';
import 'package:eljur_students/features/schedule/presentation/widgets/day_view.dart';
import 'package:eljur_students/features/schedule/presentation/widgets/schedule_error.dart';
import 'package:eljur_students/features/schedule/presentation/widgets/vacation.dart';
import 'package:flutter/material.dart';

class DaysView extends StatefulWidget {
  final List<ScheduleDay> days;

  const DaysView({super.key, required this.days});

  @override
  State<DaysView> createState() => _DaysViewState();
}

class _DaysViewState extends State<DaysView> {
  static const todayPageId = 100000;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: PageController(
        initialPage: todayPageId,
      ),
      itemCount: todayPageId * 2,
      itemBuilder: (context, index) {
        var currentDay = DateTime.now();
        currentDay =
            DateTime(currentDay.year, currentDay.month, currentDay.day);
        var day = currentDay.add(Duration(days: index - todayPageId));
        var dayId =
            widget.days.indexWhere((element) => element.dateTime == day);
        if (dayId == -1) {
          if (widget.days.first.dateTime.isBefore(day) ||
              widget.days.last.dateTime.isAfter(day)) {
            return Center(
              child: FutureBuilder(
                future: locator<GetScheduleForDateUseCase>()(
                    GetScheduleForDateUseCaseParams(day: day)),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.fold((l) => const ScheduleError(),
                        (r) => r == null ? const Vacation() : DayView(day: r));
                  } else if (snapshot.hasError) {
                    return const ScheduleError();
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            );
          } else {
            return const Vacation();
          }
        } else {
          return DayView(day: widget.days[dayId]);
        }
      },
    );
  }
}
