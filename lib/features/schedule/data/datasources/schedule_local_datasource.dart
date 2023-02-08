import 'package:eljur_students/core/dynamic_db/dynamic_db.dart';
import 'package:eljur_students/core/errors/exceptions/cache_exception.dart';
import 'package:eljur_students/features/schedule/data/models/schedule_day_model.dart';
import 'package:sembast/sembast.dart';

abstract class ScheduleLocalDataSource {
  Future<List<ScheduleDayModel>> getSchedule();
  Future<void> cacheSchedule(List<ScheduleDayModel> schedule);
}

class ScheduleLocalDataSourceImpl implements ScheduleLocalDataSource {
  final DynamicDb dynamicDb;
  final StoreRef store = stringMapStoreFactory.store('schedule');

  ScheduleLocalDataSourceImpl({required this.dynamicDb});

  @override
  Future<List<ScheduleDayModel>> getSchedule() async {
    final result = await store.record('schedule').get(await dynamicDb.database);
    if (result == null) throw CacheException();
    return (result as List<dynamic>)
        .toList()
        .map((e) => ScheduleDayModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> cacheSchedule(List<ScheduleDayModel> schedule) async =>
      store.record('schedule').put(
          await dynamicDb.database,
          schedule
              .map(
                (e) => e.toJson(),
              )
              .toList());
}
