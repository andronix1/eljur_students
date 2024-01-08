import 'package:eljur_students/di.dart';
import 'package:eljur_students/features/auth/presentation/screens/credentials_auth/credentials_auth_cubit.dart';
import 'package:eljur_students/features/auth/presentation/screens/credentials_auth/credentials_auth_state.dart';
import 'package:eljur_students/features/auth/presentation/screens/credentials_auth/widgets/credentials_auth_authenticated.dart';
import 'package:eljur_students/features/auth/presentation/screens/credentials_auth/widgets/credentials_auth_loading_screen.dart';
import 'package:eljur_students/features/auth/presentation/screens/credentials_auth/widgets/credentials_auth_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CredentialsAuthScreen extends StatelessWidget {
  const CredentialsAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CredentialsAuthCubit>(),
      child: BlocBuilder<CredentialsAuthCubit, CredentialsAuthState>(
          builder: (context, state) => switch (state) {
                CredentialsAuthMainScreenState(error: var error) =>
                  CredentialsAuthMainScreen(
                      error: error,
                      auth:
                          BlocProvider.of<CredentialsAuthCubit>(context).auth),
                CredentialsAuthLoading() =>
                  const CredentialsAuthLoadingScreen(),
                CredentialsAuthSuccess(userInfo: var userInfo) =>
                  CredentialsAuthAuthenticatedScreen(
                    userName: '${userInfo.middleName} ${userInfo.firstName}',
                    onContinue: () => context.go('/auth'),
                  ),
              }),
    );
  }
}
