sealed class TokenAuthState {}

sealed class TokenAuthErrorState {}

class TokenAuthStringErrorState extends TokenAuthErrorState {
  final String message;

  TokenAuthStringErrorState({required this.message});
}

class TokenAuthUnknownErrorState extends TokenAuthErrorState {}

class TokenAuthMainScreenState extends TokenAuthState {
  final TokenAuthErrorState? error;

  TokenAuthMainScreenState({this.error});
}

class TokenAuthAuthenticatingState extends TokenAuthState {}

class TokenAuthSuccessState extends TokenAuthState {}
