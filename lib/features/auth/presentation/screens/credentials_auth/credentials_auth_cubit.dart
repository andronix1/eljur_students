import 'package:eljur_students/core/eljur/api_response.dart';
import 'package:eljur_students/features/auth/data/auth_methods/credentials_auth_method.dart';
import 'package:eljur_students/features/auth/domain/auth_provider.dart';
import 'package:eljur_students/features/auth/presentation/screens/credentials_auth/credentials_auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CredentialsAuthCubit extends Cubit<CredentialsAuthState> {
  final AuthProvider authProvider;
  final CredentialsAuthMethodFactory credentialsAuthMethodFactory;

  CredentialsAuthCubit(
      {required this.authProvider, required this.credentialsAuthMethodFactory})
      : super(CredentialsAuthMainScreenState());

  void auth(String username, String password) {
    emit(CredentialsAuthLoading());
    authProvider
        .auth(credentialsAuthMethodFactory.withCredentials(username, password))
        .then((value) => value.match(
                (user) => {
                      emit(CredentialsAuthSuccess(userInfo: user.userInfo))
                    }, (failure) {
              switch (failure) {
                case ApiError(message: var message):
                  emit(CredentialsAuthMainScreenState(
                      error:
                          CredentialsAuthStringErrorState(message: message)));
                  break;
                default:
                  emit(CredentialsAuthMainScreenState(
                      error: CredentialsAuthUnknownErrorState()));
                  break;
              }
            }));
  }
}
