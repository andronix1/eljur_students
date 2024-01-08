import 'package:eljur_students/di.dart';
import 'package:eljur_students/features/auth/presentation/routes.dart';
import 'package:eljur_students/features/diary/presentation/screens/diary_view/diary_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter router = GoRouter(routes: [
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => Scaffold(
              body: SafeArea(child: navigationShell),
            ),
        branches: [
          getAuthBranch(),
          StatefulShellBranch(routes: [
            GoRoute(
                path: '/app',
                builder: (context, state) => const DiaryViewScreen())
          ])
        ])
  ], initialLocation: '/auth');

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Eljur.Students',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
