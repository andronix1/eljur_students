part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthDataLoading extends AuthState {}

class AuthDataLoaded extends AuthState {}

class AuthDataInvalidCredentialsError extends AuthState {}

class AuthDataServerError extends AuthState {}
