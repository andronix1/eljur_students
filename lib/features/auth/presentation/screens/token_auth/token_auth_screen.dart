import 'package:eljur_students/di.dart';
import 'package:eljur_students/features/auth/domain/models/auth_info.dart';
import 'package:eljur_students/features/auth/presentation/screens/token_auth/token_auth_cubit.dart';
import 'package:eljur_students/features/auth/presentation/screens/token_auth/token_auth_state.dart';
import 'package:eljur_students/features/auth/presentation/screens/token_auth/widgets/token_auth_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenAuthScreen extends StatelessWidget {
  const TokenAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TokenAuthCubit>(),
      child: BlocBuilder<TokenAuthCubit, TokenAuthState>(
        builder: (context, state) => switch (state) {
          TokenAuthMainScreenState(error: var error) => TokenAuthMainScreen(
              error: error,
              auth: (token, expiresAt) =>
                  BlocProvider.of<TokenAuthCubit>(context).setAuthInfo(
                      AuthInfo(token: token, expiresAt: expiresAt)),
            ),
          TokenAuthAuthenticatingState() => const Text("authenticating..."),
          TokenAuthSuccessState() => const Text("FINISHED!"),
        },
      ),
    );
  }
}
