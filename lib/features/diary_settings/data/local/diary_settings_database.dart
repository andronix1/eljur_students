import 'package:eljur_students/core/database/user_database.dart';
import 'package:eljur_students/core/failure/failure.dart';
import 'package:eljur_students/features/diary_settings/domain/diary_settings_database.dart';
import 'package:eljur_students/features/diary_settings/domain/models/settings.dart';

class SembastDiarySettingsDatabase implements DiarySettingsDatabase {
  final UserScopedDatabase database;

  SembastDiarySettingsDatabase({required this.database});

  @override
  Future<Failable<DiarySettings>> getDiarySettings() {
    database.
  }

  @override
  Future<Failable<void>> setDiarySettings(DiarySettings settings) {
    // TODO: implement setDiarySettings
    throw UnimplementedError();
  }

}