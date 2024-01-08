import 'package:eljur_students/features/diary/domain/models/homework_file_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'homework_file_info_dto.g.dart';

@JsonSerializable()
class SembastHomeworkFileInfoDto {
  final String value;
  final Uri destination;

  SembastHomeworkFileInfoDto({required this.destination, required this.value});

  factory SembastHomeworkFileInfoDto.fromJson(Map<String, dynamic> json) => _$SembastHomeworkFileInfoDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SembastHomeworkFileInfoDtoToJson(this);

  factory SembastHomeworkFileInfoDto.fromHomeworkFileInfo(HomeworkFileInfo fileInfo) => SembastHomeworkFileInfoDto(destination: fileInfo.destination, value: fileInfo.value);
  HomeworkFileInfo toHomeworkFileInfo() => HomeworkFileInfo(destination: destination, value: value);
}