import 'package:eljur_students/core/failure/failure.dart';
import 'package:eljur_students/features/auth/domain/models/user.dart';
import 'package:eljur_students/features/auth/domain/users_repository.dart';

abstract class UsersDatabase {
  Future<Failable<void>> addUser(User user);
  Future<Failable<void>> deleteUser(UserId userId);
  Future<Failable<User>> getUser(UserId userId);
  Future<Failable<List<User>>> getUsers();
  Future<Failable<void>> setDefaultUser(UserId userId);
  Future<Failable<DefaultUser>> getDefaultUser();
  Future<Failable<void>> clearDefaultUser();
}
