import 'package:flutter/material.dart';

class CredentialsAuthAuthenticatedScreen extends StatelessWidget {
  final String userName;
  final void Function()? onContinue;

  const CredentialsAuthAuthenticatedScreen(
      {super.key, required this.userName, this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Здравствуйте, $userName",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: onContinue, child: const Text("Продолжить"))
      ],
    );
  }
}
