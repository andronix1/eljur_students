import 'package:eljur_students/features/auth/presentation/screens/auth_home/auth_home_screen.dart';
import 'package:eljur_students/features/auth/presentation/screens/credentials_auth/credentials_auth_screen.dart';
import 'package:eljur_students/features/auth/presentation/screens/token_auth/token_auth_screen.dart';
import 'package:go_router/go_router.dart';

StatefulShellBranch getAuthBranch() {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthHomeScreen(),
        routes: [
          GoRoute(
            path: 'token',
            builder: (context, state) => const TokenAuthScreen(),
          ),
          GoRoute(
            path: 'credentials',
            builder: (context, state) => const CredentialsAuthScreen(),
          ),
        ],
      ),
    ],
  );
}
