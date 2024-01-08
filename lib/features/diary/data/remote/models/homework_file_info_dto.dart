import 'package:eljur_students/features/diary/domain/models/homework_file_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'homework_file_info_dto.g.dart';

@JsonSerializable(createToJson: false)
class HomeworkFileInfoDto {
  @JsonKey(name: 'toid')
  final int toId;
  final String filename;
  final Uri link;

  HomeworkFileInfoDto({required this.link, required this.filename, required this.toId});

  factory HomeworkFileInfoDto.fromJson(Map<String, dynamic> json) => _$HomeworkFileInfoDtoFromJson(json);

  HomeworkFileInfo toHomeworkFileInfo() => HomeworkFileInfo(destination: link, value: filename);
}