import 'package:eljur_students/di.dart';
import 'package:eljur_students/features/auth/domain/auth_provider.dart';
import 'package:eljur_students/router/app_router.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDi();
  runApp(EljurStudentsApp());
}

class EljurStudentsApp extends StatelessWidget {
  EljurStudentsApp({super.key});

  final _router =
      AppRouter(initialAuthenticated: getIt<AuthProvider>().user != null);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'элжур студентс',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      routerConfig: _router.config(),
    );
  }
}
