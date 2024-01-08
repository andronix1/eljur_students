import 'package:eljur_students/core/failure/failure.dart';
import 'package:eljur_students/features/auth/domain/models/auth_info.dart';

abstract class AuthMethod {
  Future<Failable<AuthInfo>> getAuthInfo();
}
