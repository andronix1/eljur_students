import 'package:eljur_students/features/auth/presentation/screens/credentials_auth/credentials_auth_state.dart';
import 'package:flutter/material.dart';

class CredentialsAuthMainScreen extends StatefulWidget {
  final CredentialsAuthErrorState? error;
  final void Function(String username, String password)? auth;

  const CredentialsAuthMainScreen({super.key, this.error, this.auth});

  @override
  State<CredentialsAuthMainScreen> createState() =>
      _CredentialsAuthMainScreenState();
}

class _CredentialsAuthMainScreenState extends State<CredentialsAuthMainScreen> {
  final TextEditingController usernameInputController = TextEditingController(),
      passwordInputController = TextEditingController();

  bool hidePassword = true;

  void _auth() => widget.auth
      ?.call(usernameInputController.text, passwordInputController.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Вход",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 50),
          TextField(
            controller: usernameInputController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.password),
                onPressed: () => setState(() {
                  hidePassword = !hidePassword;
                }),
              ),
            ),
            controller: passwordInputController,
            obscureText: hidePassword,
          ),
          const SizedBox(height: 10),
          if (widget.error != null)
            Text(switch (widget.error!) {
              CredentialsAuthStringErrorState(message: var message) => message,
              CredentialsAuthUnknownErrorState() => "неизвестная ошибка",
            }),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _auth, child: const Text("Войти"))
        ],
      ),
    );
  }
}
