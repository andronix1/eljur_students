import 'package:eljur_students/core/failure/failure.dart';
import 'package:eljur_students/features/diary_settings/diary_settings_database.dart';
import 'package:eljur_students/features/diary_settings/domain/models/settings.dart';

class DiarySettingsRepository {
  final DiarySettingsDatabase database;

  DiarySettingsRepository({required this.database});

  Future<Failable<DiarySettings>> getDiarySettings() => database.getDiarySettings();
  Future<Failable<void>> setDiarySettings(DiarySettings settings) => database.setDiarySettings(settings);
}