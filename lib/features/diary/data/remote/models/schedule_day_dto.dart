import 'package:eljur_students/features/diary/data/remote/models/lesson_dto.dart';
import 'package:eljur_students/features/diary/domain/models/schedule_day.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_day_dto.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class ScheduleDayDto {
  @JsonKey(name: 'name')
  final DateTime day;
  @JsonKey(name: 'items', fromJson: _lessonsFromJson)
  final List<LessonDto> lessons;

  // РАЗРАБ, ТЫ ПОД КАКИМИ СОЛЯМИ ЭТУ API ПИСАЛ?!
  static List<LessonDto> _lessonsFromJson(dynamic items) {
    items = items ?? [];
    if (items is Map<String, dynamic>) {
      items = items.values.toList();
    }

    // Ингода массив возвращается, иногда мапа, иногда null, а иногда поля нет.
    // Напоминаю: РАЗРАБ - КОНЧ!!!
    return (items as List<dynamic>).map((e) => LessonDto.fromJson(e)).toList();
  }

  ScheduleDayDto({required this.lessons, required this.day});

  factory ScheduleDayDto.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDayDtoFromJson(json);

  ScheduleDay toScheduleDay() => lessons.isEmpty
      ? ScheduleVacationDay()
      : ScheduleWorkDay(lessons: lessons.map((e) => e.toLesson()).toList());
}
