import 'package:eljur_students/features/auth/presentation/widgets/select_user/select_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            const Text(
              "Добро пожаловать в scheduler!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SelectUserWidget(),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () => context.go('/auth/credentials'),
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
              onPressed: () => context.go('/auth/token'),
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
