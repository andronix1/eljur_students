import 'package:eljur_students/core/eljur/api_response.dart';
import 'package:eljur_students/features/auth/data/auth_methods/token_auth_method.dart';
import 'package:eljur_students/features/auth/domain/models/auth_info.dart';
import 'package:eljur_students/features/auth/domain/auth_provider.dart';
import 'package:eljur_students/features/auth/presentation/screens/token_auth/token_auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenAuthCubit extends Cubit<TokenAuthState> {
  final AuthProvider authProvider;

  TokenAuthCubit({required this.authProvider})
      : super(TokenAuthMainScreenState());

  void setAuthInfo(AuthInfo authInfo) {
    emit(TokenAuthAuthenticatingState());
    authProvider.auth(TokenAuthMethod(authInfo: authInfo)).then((value) {
      value.match((user) => emit(TokenAuthSuccessState()), (failure) {
        switch (failure) {
          case ApiError(message: var message):
            emit(TokenAuthMainScreenState(
                error: TokenAuthStringErrorState(message: message)));
            break;
          default:
            emit(TokenAuthMainScreenState(error: TokenAuthUnknownErrorState()));
            break;
        }
      });
    });
  }
}
