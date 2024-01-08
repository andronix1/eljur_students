import 'package:eljur_students/features/auth/domain/models/user_info.dart';

sealed class CredentialsAuthErrorState {}

class CredentialsAuthStringErrorState extends CredentialsAuthErrorState {
  final String message;

  CredentialsAuthStringErrorState({required this.message});
}

class CredentialsAuthUnknownErrorState extends CredentialsAuthErrorState {}

sealed class CredentialsAuthState {}

class CredentialsAuthMainScreenState extends CredentialsAuthState {
  final CredentialsAuthErrorState? error;

  CredentialsAuthMainScreenState({this.error});
}

class CredentialsAuthLoading extends CredentialsAuthState {}

class CredentialsAuthSuccess extends CredentialsAuthState {
  final UserInfo userInfo;

  CredentialsAuthSuccess({required this.userInfo});
}
