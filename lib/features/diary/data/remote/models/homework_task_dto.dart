import 'package:eljur_students/features/diary/data/remote/models/homework_file_info_dto.dart';
import 'package:eljur_students/features/diary/domain/models/homework_task.dart';
import 'package:json_annotation/json_annotation.dart';

part 'homework_task_dto.g.dart';

@JsonSerializable(createToJson: false)
class HomeworkTaskDto {
  final String value;
  final int id;
  final bool individual;

  HomeworkTaskDto({required this.value, required this.individual, required this.id});

  factory HomeworkTaskDto.fromJson(Map<String, dynamic> json) => _$HomeworkTaskDtoFromJson(json);

  HomeworkTask toHomeworkTask(List<HomeworkFileInfoDto> files) => HomeworkTask(text: value, files: files.map((e) => e.toHomeworkFileInfo()).toList());
}