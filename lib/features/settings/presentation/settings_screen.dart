import 'package:auto_route/auto_route.dart';
import 'package:eljur_students/di.dart';
import 'package:eljur_students/features/auth/domain/auth_provider.dart';
import 'package:eljur_students/router/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Аутентификация"),
        ElevatedButton(
            onPressed: () => getIt<AuthProvider>().signOut().then((value) =>
                value.matchOk(
                    (result) => context.navigateTo(const AuthAppRoute()))),
            child: const Text("Сменить аккаунт")),
      ],
    );
  }
}
