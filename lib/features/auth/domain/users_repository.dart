import 'package:eljur_students/core/failure/failure.dart';
import 'package:eljur_students/features/auth/domain/auth_method.dart';
import 'package:eljur_students/features/auth/domain/users_database.dart';
import 'package:eljur_students/features/auth/domain/models/user.dart';
import 'package:eljur_students/features/auth/domain/users_remote.dart';
import 'package:oxidized/oxidized.dart';

class NoSuchUserFailure extends Failure {}

class UsersRepository {
  final UsersDatabase database;
  final UsersRemote remote;

  UsersRepository({required this.database, required this.remote});

  Future<Failable<void>> addUser(User user) => database.addUser(user);
  Future<Failable<void>> deleteUser(UserId userId) =>
      database.deleteUser(userId);
  Future<Failable<User>> getUser(UserId userId) => database.getUser(userId);
  Future<Failable<List<User>>> getUsers() => database.getUsers();
  Future<Failable<User>> auth(AuthMethod authMethod) =>
      remote.getUser(authMethod).andThenAsync((user) =>
          database.addUser(user).then((result) => result.map((_) => user)));
}
