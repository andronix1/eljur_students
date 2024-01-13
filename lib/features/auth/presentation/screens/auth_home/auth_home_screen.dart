import 'package:auto_route/auto_route.dart';
import 'package:eljur_students/features/auth/presentation/widgets/select_user/select_user_widget.dart';
import 'package:eljur_students/router/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AuthHomeScreen extends StatefulWidget {
  const AuthHomeScreen({super.key});

  @override
  State<AuthHomeScreen> createState() => _AuthHomeScreenState();
}

class _AuthHomeScreenState extends State<AuthHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Добро пожаловать в scheduler!",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 10),
            const SelectUserWidget(),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => context.pushRoute(const CredentialsAuthRoute()),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_box),
                  SizedBox(width: 10),
                  Text("Войти по логину и паролю"),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () => context.pushRoute(const TokenAuthRoute()),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bug_report),
                  SizedBox(width: 10),
                  Text("Войти с помощью токена"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
