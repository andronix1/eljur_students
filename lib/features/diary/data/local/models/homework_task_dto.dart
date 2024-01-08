import 'package:eljur_students/features/diary/data/local/models/homework_file_info_dto.dart';
import 'package:eljur_students/features/diary/domain/models/homework_task.dart';
import 'package:json_annotation/json_annotation.dart';

part 'homework_task_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class SembastHomeworkTaskDto {
  final String text;
  final List<SembastHomeworkFileInfoDto> files;

  SembastHomeworkTaskDto({required this.text, required this.files});

  factory SembastHomeworkTaskDto.fromJson(Map<String, dynamic> json) => _$SembastHomeworkTaskDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SembastHomeworkTaskDtoToJson(this);

  factory SembastHomeworkTaskDto.fromHomeworkTask(HomeworkTask task) => SembastHomeworkTaskDto(text: task.text, files: task.files.map(SembastHomeworkFileInfoDto.fromHomeworkFileInfo).toList());
  HomeworkTask toHomeworkTask() => HomeworkTask(text: text, files: files.map((e) => e.toHomeworkFileInfo()).toList());
}