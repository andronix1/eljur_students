import 'package:eljur_students/features/auth/domain/models/auth_info.dart';
import 'package:eljur_students/features/auth/domain/models/user_info.dart';

typedef UserId = int;

class User {
  final AuthInfo authInfo;
  final UserInfo userInfo;

  User({required this.authInfo, required this.userInfo});
}