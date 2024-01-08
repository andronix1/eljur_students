import 'package:eljur_students/core/failure/failure.dart';
import 'package:eljur_students/features/auth/domain/auth_method.dart';
import 'package:eljur_students/features/auth/domain/models/user.dart';

abstract class UsersRemote {
  Future<Failable<User>> getUser(AuthMethod authMethod);
}
