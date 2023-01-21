import 'package:eljur_students/core/errors/failures/server_failure.dart';
import 'package:eljur_students/features/eljur_auth/data/repositories/accounts_repository.dart';
import 'package:eljur_students/features/eljur_auth/domain/entities/account_entity.dart';
import 'package:eljur_students/features/eljur_auth/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthLoginEvent) {
        emit(AuthDataLoading());

        (await loginUseCase(LoginParams(authInfo: event.authInfo))).fold((l) {
          if (l is AuthFailure) {
            emit(AuthDataInvalidCredentialsError());
          } else if (l is ServerFailure) {
            emit(AuthDataServerError());
          }
        }, (r) => emit(AuthDataLoaded()));
      }
    });
  }
}
