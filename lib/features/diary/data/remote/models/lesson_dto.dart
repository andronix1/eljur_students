import 'package:eljur_students/features/diary/data/remote/models/assessment_dto.dart';
import 'package:eljur_students/features/diary/data/remote/models/day_time_dto.dart';
import 'package:eljur_students/features/diary/data/remote/models/homework_file_info_dto.dart';
import 'package:eljur_students/features/diary/data/remote/models/homework_task_dto.dart';
import 'package:eljur_students/features/diary/domain/models/homework_task.dart';
import 'package:eljur_students/features/diary/domain/models/lesson.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lesson_dto.g.dart';

@JsonSerializable(createToJson: false)
class LessonDto {
  @JsonKey(name: 'num')
  final String number; // А ПОЧЕМУ БЫ СОБСТВЕННО И НЕТ???
  final String name, room, teacher;
  @JsonKey(name: 'starttime')
  final DayTimeDto startsAt;
  @JsonKey(name: 'endtime')
  final DayTimeDto endsAt;
  @JsonKey(defaultValue: [])
  final List<HomeworkFileInfoDto> files;
  @JsonKey(defaultValue: [])
  final List<AssessmentDto> assessments;
  @JsonKey(defaultValue: {})
  final Map<String, HomeworkTaskDto> homework;

  LessonDto(
      {required this.name,
      required this.number,
      required this.files,
      required this.room,
      required this.teacher,
      required this.startsAt,
      required this.endsAt,
      required this.assessments,
      required this.homework});

  factory LessonDto.fromJson(Map<String, dynamic> json) =>
      _$LessonDtoFromJson(json);

  List<HomeworkTask> _getTasks(bool isIndividual) => homework.values
      .where((e) => isIndividual == e.individual)
      .map((e) => e.toHomeworkTask(files.where((f) => f.toId == e.id).toList()))
      .toList();

  Lesson toLesson() => Lesson(
      number: int.parse(number),
      name: name,
      room: room,
      teacher: teacher,
      startsAt: startsAt.toDayTime(),
      endsAt: endsAt.toDayTime(),
      homework: _getTasks(false),
      individualHomework: _getTasks(true),
      assessments: assessments.map((e) => e.toAssessment()).toList());
}
