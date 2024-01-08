import 'package:eljur_students/features/diary/domain/models/assessment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'assessment_dto.g.dart';

@JsonSerializable(createToJson: false)
class AssessmentDto {
  final String value;
  final String? comment;

  AssessmentDto({required this.value, required this.comment});

  factory AssessmentDto.fromJson(Map<String, dynamic> json) => _$AssessmentDtoFromJson(json);

  Assessment toAssessment() => Assessment(value: value, comment: comment);
}