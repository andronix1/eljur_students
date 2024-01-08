import 'package:eljur_students/features/diary/domain/models/assessment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'assessment_dto.g.dart';

@JsonSerializable()
class SembastAssessmentDto {
  final String value;
  final String? comment;

  SembastAssessmentDto({required this.value, required this.comment});

  factory SembastAssessmentDto.fromJson(Map<String, dynamic> json) => _$SembastAssessmentDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SembastAssessmentDtoToJson(this);

  factory SembastAssessmentDto.fromAssessment(Assessment assessment) => SembastAssessmentDto(value: assessment.value, comment: assessment.comment);
  Assessment toAssessment() => Assessment(value: value, comment: comment);
}