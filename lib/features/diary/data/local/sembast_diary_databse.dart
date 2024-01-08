import 'package:eljur_students/core/database/user_database.dart';
import 'package:eljur_students/core/failure/cache_failure.dart';
import 'package:eljur_students/core/failure/failure.dart';
import 'package:eljur_students/features/diary/data/local/models/schedule_dto.dart';
import 'package:eljur_students/features/diary/domain/diary_database.dart';
import 'package:eljur_students/features/diary/domain/models/schedule.dart';
import 'package:oxidized/oxidized.dart';
import 'package:sembast/sembast.dart';

const String _defaultDiaryRecord = 'defaultDiary';

class SembastDiaryDatabase implements DiaryDatabase {
  final CurrentUserDatabase database;
  final StoreRef<String, Map<String, dynamic>> store = StoreRef('diary');

  SembastDiaryDatabase({required this.database});

  @override
  Future<Failable<Schedule>> getSchedule() => CacheFailure.tryCatchAsync(() async {
    var record = await store.record(_defaultDiaryRecord).get(await database.getDatabase());
    return record == null ? 
      Err(WasNotCached()) : 
      Ok(SembastScheduleDto.fromJson(record).toSchedule());
  });
  
  @override
  Future<Failable<void>> setSchedule(Schedule schedule) => CacheFailure.tryCatchAsync(() async => 
    Ok(await store.record(_defaultDiaryRecord)
      .put(await database.getDatabase(), SembastScheduleDto.fromSchedule(schedule).toJson()))
  );
}