import 'package:flutter/material.dart';

class CredentialsAuthLoadingScreen extends StatelessWidget {
  const CredentialsAuthLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "подождите...",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 40),
        CircularProgressIndicator()
      ],
    );
  }
}
