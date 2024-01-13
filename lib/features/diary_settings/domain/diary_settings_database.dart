import 'package:eljur_students/core/failure/failure.dart';
import 'package:eljur_students/features/diary_settings/domain/models/settings.dart';

abstract class DiarySettingsDatabase {
  Future<Failable<DiarySettings>> getDiarySettings();
  Future<Failable<void>> setDiarySettings(DiarySettings settings);
}