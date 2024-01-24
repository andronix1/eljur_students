import 'package:auto_route/auto_route.dart';
import 'package:eljur_students/features/auth/presentation/screens/auth_home/auth_home_screen.dart';
import 'package:eljur_students/features/auth/presentation/screens/credentials_auth/credentials_auth_screen.dart';
import 'package:eljur_students/features/auth/presentation/screens/token_auth/token_auth_screen.dart';
import 'package:eljur_students/features/diary/presentation/screens/diary_view/diary_view_screen.dart';
import 'package:eljur_students/features/settings/presentation/settings_screen.dart';
import 'package:eljur_students/router/presentation/main_app.dart';
import 'package:eljur_students/router/presentation/auth_app.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  final bool initialAuthenticated;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            page: AuthAppRoute.page,
            initial: !initialAuthenticated,
            children: [
              AutoRoute(page: AuthHomeRoute.page, initial: true),
              AutoRoute(page: CredentialsAuthRoute.page),
              AutoRoute(page: TokenAuthRoute.page)
            ]),
        AutoRoute(
            page: MainAppRoute.page,
            initial: initialAuthenticated,
            keepHistory: false,
            children: [
              AutoRoute(page: DiaryViewRoute.page, initial: true),
              AutoRoute(page: SettingsRoute.page),
            ]),
      ];

  AppRouter({required this.initialAuthenticated});
}
