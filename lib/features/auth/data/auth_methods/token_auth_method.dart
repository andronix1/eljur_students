import 'package:eljur_students/core/failure/failure.dart';
import 'package:eljur_students/features/auth/domain/auth_method.dart';
import 'package:eljur_students/features/auth/domain/models/auth_info.dart';
import 'package:oxidized/oxidized.dart';

class TokenAuthMethod implements AuthMethod {
  final AuthInfo authInfo;

  TokenAuthMethod({required this.authInfo});

  @override
  Future<Failable<AuthInfo>> getAuthInfo() => Future.value(Ok(authInfo));
}
