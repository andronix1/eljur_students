import 'package:flutter/material.dart';

class CredentialsAuthLoadingScreen extends StatelessWidget {
  const CredentialsAuthLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "подождите...",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 40),
        const CircularProgressIndicator()
      ],
    );
  }
}
