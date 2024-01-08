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
  final StoreRef<UserId, Map<String, dynamic>> store = StoreRef("users");

  SembastUsersDatabase({required this.database});

  @override
  Future<Failable<void>> addUser(User user) =>
      CacheFailure.tryCatchAsync(() async => Ok(await store
          .record(user.userInfo.userId)
          .put(database, UserSembastDto.fromUser(user).toJson())));

  @override
  Future<Failable<void>> deleteUser(UserId userId) =>
      CacheFailure.tryCatchAsync(() =>
          store.record(userId).delete(database).then((value) => 
            Future.value(value == null ? const Ok(Null) : Err(NoSuchUserFailure()))));

  @override
  Future<Failable<User>> getUser(UserId userId) async => CacheFailure.tryCatchAsync(() async {
    var dto = await store.record(userId).get(database);
    return dto == null
        ? Err(NoSuchUserFailure())
        : Ok(UserSembastDto.fromJson(dto).toUser(userId));
  });

  @override
  Future<Failable<List<User>>> getUsers() async => CacheFailure.tryCatchAsync(() async {
    var dtos = await store.find(database);
    return Ok(dtos
        .map((dto) => UserSembastDto.fromJson(dto.value).toUser(dto.key))
        .toList());
  });
}
