import 'package:eljur_students/features/auth/domain/models/user.dart';

sealed class SelectUserState {}

class SelectUserLoadingState extends SelectUserState {}

class SelectUserSelectedState extends SelectUserState {}

class SelectUserLoadingFailedState extends SelectUserState {}

class SelectUserLoadedState extends SelectUserState {
  final List<User> users;

  SelectUserLoadedState({required this.users});
}
