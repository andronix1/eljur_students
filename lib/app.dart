import 'package:eljur_students/dependency_injection.dart';
import 'package:eljur_students/features/eljur_auth/domain/repositories/accounts_repository.dart';
import 'package:eljur_students/features/eljur_auth/presentation/pages/auth_page.dart';
import 'package:eljur_students/features/schedule/presentation/pages/schedule_page.dart';
import 'package:eljur_students/routes.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        Routes.authRoute: (context) => const AuthPage(),
        Routes.mainPageRoute: (context) => const SchedulePage()
      },
      initialRoute: locator<AccountsRepository>().currentAccount == null
          ? Routes.authRoute
          : Routes.mainPageRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
