import 'package:auto_route/auto_route.dart';
import 'package:eljur_students/core/failure/cache_failure.dart';
import 'package:eljur_students/core/failure/failure.dart';
import 'package:eljur_students/core/failure/server_failure.dart';
import 'package:eljur_students/di.dart';
import 'package:eljur_students/features/diary/domain/models/day_time.dart';
import 'package:eljur_students/features/diary/domain/models/homework_file_info.dart';
import 'package:eljur_students/features/diary/domain/models/homework_task.dart';
import 'package:eljur_students/features/diary/domain/models/lesson.dart';
import 'package:eljur_students/features/diary/domain/models/schedule_day.dart';
import 'package:eljur_students/features/diary/presentation/screens/diary_view/diary_view_cubit.dart';
import 'package:eljur_students/features/diary/presentation/screens/diary_view/diary_view_state.dart';
import 'package:eljur_students/features/diary/presentation/screens/diary_view/schedule_day_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class DiaryViewScreen extends StatelessWidget {
  const DiaryViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DiaryViewCubit>(
      create: (context) => getIt<DiaryViewCubit>(),
      child: BlocBuilder<DiaryViewCubit, DiaryViewState>(
          builder: (context, state) => switch (state) {
                DiaryViewLoading() => const LoadingDay(),
                DiaryViewFailed(failure: var failure) =>
                  Text('failed: $failure'),
                DiaryViewLoaded(
                  currentDayOffset: var currentDayOffset,
                  currentPage: var currentPage,
                  nextPage: var nextPage,
                  previousPage: var previousPage
                ) =>
                  DaysView(
                      onNextPage: () =>
                          BlocProvider.of<DiaryViewCubit>(context).nextDay(),
                      onPreviousPage: () =>
                          BlocProvider.of<DiaryViewCubit>(context)
                              .previousDay(),
                      currentDayOffset: currentDayOffset,
                      currentPage: currentPage,
                      nextPage: nextPage,
                      previousPage: previousPage),
              }),
    );
  }
}

class DaysView extends StatelessWidget {
  const DaysView(
      {super.key,
      required this.onNextPage,
      required this.onPreviousPage,
      required this.currentDayOffset,
      required this.currentPage,
      required this.nextPage,
      required this.previousPage});

  final int currentDayOffset;
  final ScheduleDayState currentPage, nextPage, previousPage;
  final Function() onNextPage, onPreviousPage;

  @override
  Widget build(BuildContext context) {
    return InfinityPageView(
      onNextPage: onNextPage,
      onPreviousPage: onPreviousPage,
      itemBuilder: (context, offset) => DayView(
          scheduleDayState: [
        previousPage,
        currentPage,
        nextPage
      ][offset - currentDayOffset + 1]),
    );
  }
}

class InfinityPageView extends StatefulWidget {
  const InfinityPageView({
    super.key,
    required this.itemBuilder,
    required this.onNextPage,
    required this.onPreviousPage,
  });

  static const int _initialPage = 100000;
  final Widget Function(BuildContext context, int offset) itemBuilder;
  final Function() onNextPage, onPreviousPage;

  @override
  State<InfinityPageView> createState() => _InfinityPageViewState();
}

class _InfinityPageViewState extends State<InfinityPageView> {
  final PageController _pageController =
      PageController(initialPage: InfinityPageView._initialPage);

  int _currentPage = InfinityPageView._initialPage;

  @override
  Widget build(BuildContext context) {
    return PageView.custom(
      onPageChanged: (page) {
        if (page > _currentPage) {
          widget.onNextPage();
        } else if (page < _currentPage) {
          widget.onPreviousPage();
        }
        _currentPage = page;
      },
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) =>
            widget.itemBuilder(context, index - InfinityPageView._initialPage),
      ),
    );
  }
}

class LoadingDay extends StatelessWidget {
  const LoadingDay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class DayView extends StatelessWidget {
  const DayView({
    super.key,
    required this.scheduleDayState,
  });

  final ScheduleDayState scheduleDayState;

  String _getDateString() => "${scheduleDayState.selectedDate.day} ${[
        'января',
        'февраля',
        'марта',
        'апреля',
        'мая',
        'июня',
        'июля',
        'августа',
        'сентября',
        'октября',
        'ноября',
        'декабря',
      ][scheduleDayState.selectedDate.month - 1]}";

  String _getWeekDay() => [
        'понедельник',
        'вторник',
        'среда',
        'четверг',
        'пятница',
        'суббота',
        'воскресенье',
      ][scheduleDayState.selectedDate.weekday - 1];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          _getDateString(),
          style: theme.textTheme.headlineLarge,
        ),
        Text(
          _getWeekDay(),
          style: theme.textTheme.labelLarge,
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: switch (scheduleDayState) {
            ScheduleDayLoading() => const LoadingDay(),
            ScheduleDayLoadingFailure(failure: var failure) =>
              FailureView(failure: failure),
            ScheduleDayLoaded(scheduleDay: var scheduleDay) => switch (
                  scheduleDay) {
                ScheduleWorkDay(lessons: var lessons) => ListView.builder(
                    itemCount: lessons.length,
                    itemBuilder: (context, lessonId) =>
                        LessonCard(lesson: lessons[lessonId])),
                ScheduleVacationDay() => const Vacation(),
              }
          },
        ),
      ],
    );
  }
}

class FailureView extends StatelessWidget {
  const FailureView({
    super.key,
    required this.failure,
  });

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: switch (failure) {
        ServerFailure(reason: var reason) => Text('ошибка соединения: $reason'),
        CacheFailure(reason: var reason) => Text('ошибка кэширования: $reason'),
        _ => const Text('неизветная ошибка'),
      },
    ));
  }
}

class Vacation extends StatelessWidget {
  const Vacation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.weekend_rounded,
          size: 100,
        ),
        Text(
          'выходной',
          style: theme.textTheme.titleLarge,
        ),
      ],
    );
  }
}

class LessonCard extends StatelessWidget {
  const LessonCard({
    super.key,
    required this.lesson,
  });

  final Lesson lesson;

  String _formatTime(DayTime dayTime) =>
      "${dayTime.hour}:${dayTime.minute.toString().padLeft(2, '0')}";
  String _getLessonTime() =>
      "${_formatTime(lesson.startsAt)} - ${_formatTime(lesson.endsAt)}";
  String _getFullLessonName() => "${lesson.number}. ${lesson.name}";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _getLessonTime(),
            style: theme.textTheme.labelSmall,
          ),
          NameAndRoom(
            name: _getFullLessonName(),
            room: lesson.room,
          ),
          Text(
            lesson.teacher,
            style: theme.textTheme.labelSmall,
          ),
          if (lesson.homework.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: lesson.homework
                  .map((task) => HomeworkTaskWidget(task: task))
                  .toList(),
            )
        ],
      ),
    ));
  }
}

class HomeworkTaskWidget extends StatelessWidget {
  const HomeworkTaskWidget({super.key, required this.task});

  final HomeworkTask task;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        if (task.text.isNotEmpty) Text(task.text),
        if (task.files.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: task.files.map((file) => FileView(file: file)).toList(),
          )
      ],
    );
  }
}

class FileView extends StatelessWidget {
  const FileView({super.key, required this.file});

  final HomeworkFileInfo file;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
        onPressed: () => launchUrl(file.destination),
        child: Text(
          file.value,
          style: theme.textTheme.labelSmall,
        ));
  }
}

class NameAndRoom extends StatelessWidget {
  const NameAndRoom({
    super.key,
    required this.name,
    required this.room,
  });

  final String name, room;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Text(
            name,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleLarge,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          room,
          style: theme.textTheme.labelMedium,
        ),
      ],
    );
  }
}
