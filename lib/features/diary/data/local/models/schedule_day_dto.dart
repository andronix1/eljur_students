import 'package:eljur_students/features/diary/data/local/models/lesson_dto.dart';
import 'package:eljur_students/features/diary/domain/models/schedule_day.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_day_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class SembastScheduleDayDto {
  final bool isVacation;
  final List<SembastLessonDto> lessons;

  SembastScheduleDayDto({required this.lessons, required this.isVacation});

  factory SembastScheduleDayDto.fromJson(Map<String, dynamic> json) =>
      _$SembastScheduleDayDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SembastScheduleDayDtoToJson(this);

  factory SembastScheduleDayDto.fromScheduleDay(ScheduleDay day) =>
      switch (day) {
        ScheduleWorkDay(lessons: var lessons) => SembastScheduleDayDto(
            isVacation: false,
            lessons: lessons.map(SembastLessonDto.fromLesson).toList()),
        ScheduleVacationDay() =>
          SembastScheduleDayDto(lessons: [], isVacation: true)
      };
  ScheduleDay toScheduleDay() => isVacation
      ? ScheduleVacationDay()
      : ScheduleWorkDay(lessons: lessons.map((e) => e.toLesson()).toList());
}
