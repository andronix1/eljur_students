import 'package:eljur_students/core/failure/cache_failure.dart';
import 'package:eljur_students/core/failure/failure.dart';
import 'package:eljur_students/features/auth/data/local/user_sembast_dto.dart';
import 'package:eljur_students/features/auth/domain/models/user.dart';
import 'package:eljur_students/features/auth/domain/users_database.dart';
import 'package:eljur_students/features/auth/domain/users_repository.dart';
import 'package:oxidized/oxidized.dart';
import 'package:sembast/sembast.dart';

class SembastUsersDatabase extends UsersDatabase {
  final Database database;
  final StoreRef<UserId, Map<String, dynamic>> usersStore = StoreRef("users");
  final StoreRef<String, dynamic> settingsStore = StoreRef("usersSettings");

  static const String selectedUserRecord = "selectedUserId";

  SembastUsersDatabase({required this.database});

  @override
  Future<Failable<void>> addUser(User user) =>
      CacheFailure.tryCatchAsync(() async => Ok(await usersStore
          .record(user.userInfo.userId)
          .put(database, UserSembastDto.fromUser(user).toJson())));

  @override
  Future<Failable<void>> deleteUser(UserId userId) =>
      CacheFailure.tryCatchAsync(() async {
        var deletedKey = await usersStore.record(userId).delete(database);
        if (deletedKey == null) {
          return Err(NoSuchUserFailure());
        } else {
          var record = settingsStore.record(selectedUserRecord);
          if (await record.get(database) == userId) {
            await record.delete(database);
          }
          return const Ok(Null);
        }
      });

  @override
  Future<Failable<User>> getUser(UserId userId) async =>
      CacheFailure.tryCatchAsync(() async {
        var dto = await usersStore.record(userId).get(database);
        return dto == null
            ? Err(NoSuchUserFailure())
            : Ok(UserSembastDto.fromJson(dto).toUser(userId));
      });

  @override
  Future<Failable<List<User>>> getUsers() async =>
      CacheFailure.tryCatchAsync(() async {
        var dtos = await usersStore.find(database);
        return Ok(dtos
            .map((dto) => UserSembastDto.fromJson(dto.value).toUser(dto.key))
            .toList());
      });

  @override
  Future<Failable<DefaultUser>> getDefaultUser() =>
      CacheFailure.tryCatchAsync(() async {
        var userId = await settingsStore
            .record(selectedUserRecord)
            .get(database) as UserId?;
        if (userId == null) {
          return Ok(NoDefaultUserSelected());
        }
        return await getUser(userId)
            .map((user) => DefaultUserSelected(user: user));
      });

  @override
  Future<Failable<void>> clearDefaultUser() =>
      CacheFailure.tryCatchAsync(() async {
        await settingsStore.record(selectedUserRecord).delete(database);
        return const Ok(Null);
      });

  @override
  Future<Failable<void>> setDefaultUser(UserId userId) =>
      CacheFailure.tryCatchAsync(() async => Ok(await settingsStore
          .record(selectedUserRecord)
          .put(database, userId)));
}
