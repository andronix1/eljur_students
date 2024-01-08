import 'package:eljur_students/features/diary/data/local/models/assessment_dto.dart';
import 'package:eljur_students/features/diary/data/local/models/day_time_dto.dart';
import 'package:eljur_students/features/diary/data/local/models/homework_task_dto.dart';
import 'package:eljur_students/features/diary/domain/models/lesson.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lesson_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class SembastLessonDto {
  final int number;
  final String name, room, teacher;
  final SembastDayTimeDto startsAt, endsAt;
  final List<SembastHomeworkTaskDto> homework, individualHomework;
  final List<SembastAssessmentDto> assessments;

  SembastLessonDto(
      {required this.number,
      required this.name,
      required this.room,
      required this.teacher,
      required this.startsAt,
      required this.endsAt,
      required this.assessments,
      required this.homework,
      required this.individualHomework});

  factory SembastLessonDto.fromJson(Map<String, dynamic> json) =>
      _$SembastLessonDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SembastLessonDtoToJson(this);

  factory SembastLessonDto.fromLesson(Lesson lesson) => SembastLessonDto(
        number: lesson.number,
        assessments: lesson.assessments
            .map(SembastAssessmentDto.fromAssessment)
            .toList(),
        name: lesson.name,
        room: lesson.room,
        teacher: lesson.teacher,
        startsAt: SembastDayTimeDto.fromDayTime(lesson.startsAt),
        endsAt: SembastDayTimeDto.fromDayTime(lesson.endsAt),
        homework: lesson.homework
            .map(SembastHomeworkTaskDto.fromHomeworkTask)
            .toList(),
        individualHomework: lesson.individualHomework
            .map(SembastHomeworkTaskDto.fromHomeworkTask)
            .toList(),
      );
  Lesson toLesson() => Lesson(
      number: number,
      name: name,
      room: room,
      teacher: teacher,
      startsAt: startsAt.toDayTime(),
      endsAt: endsAt.toDayTime(),
      homework: homework.map((e) => e.toHomeworkTask()).toList(),
      individualHomework:
          individualHomework.map((e) => e.toHomeworkTask()).toList(),
      assessments: assessments.map((e) => e.toAssessment()).toList());
}
