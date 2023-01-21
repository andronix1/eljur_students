part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final AuthInfo authInfo;

  AuthLoginEvent({required this.authInfo});
}
