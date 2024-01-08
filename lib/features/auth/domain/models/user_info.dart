import 'package:eljur_students/features/auth/domain/models/user.dart';

class UserInfo {
  final UserId userId;
  final String firstName, middleName, lastName;

  UserInfo({
    required this.userId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
  });
}