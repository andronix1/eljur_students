import 'package:json_annotation/json_annotation.dart';

part 'settings_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class DaysRangeDto {
  final int before, after;

  DaysRangeDto({required this.before, required this.after});

  // factory DaysRangeDto.fromJson(Map<String, dynamic> json) => ;
  // Map<String, dynamic> toJson() => ;
}

class DiarySettingsDto {
  final DaysRangeDto downloadDays;

  DiarySettingsDto({required this.downloadDays});

  // factory DiarySettingsDto.fromJson(Map<String, dynamic> json) => ;
  // Map<String, dynamic> toJson() => ;

  // factory DiarySettingsDto.fromSettings(Map<String, dynamic> json) => ;
  // Map<String, dynamic> toSettings() => ;
}