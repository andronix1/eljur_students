import 'package:eljur_students/core/date_time_extensions.dart';
import 'package:eljur_students/features/schedule/domain/entities/schedule_day.dart';
import 'package:eljur_students/features/schedule/presentation/widgets/vacation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DayView extends StatefulWidget {
  final ScheduleDay day;

  const DayView({super.key, required this.day});

  @override
  State<DayView> createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.day.dateTime.toRusString(),
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: widget.day.items.isEmpty
              ? const Vacation()
              : ListView(
                  children: [
                    for (var lesson in widget.day.items)
                      Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${lesson.startTime} - ${lesson.endTime}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${lesson.number}. ${lesson.name}',
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                  ),
                                  Text(lesson.room),
                                ],
                              ),
                              Text(lesson.teacher),
                              for (var homework in lesson.homeworks)
                                Card(
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Column(
                                      children: [
                                        Text(homework.value),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            for (var file in homework.files)
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    !await launchUrl(
                                                        Uri.parse(file.link));
                                                  },
                                                  child: Text(file.fileName))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      )
                  ],
                ),
        ),
      ],
    );
  }
}
