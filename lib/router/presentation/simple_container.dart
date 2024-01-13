import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ScaffoldWithSafeAreaScreen extends StatelessWidget {
  const ScaffoldWithSafeAreaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: AutoRouter()),
    );
  }
}
