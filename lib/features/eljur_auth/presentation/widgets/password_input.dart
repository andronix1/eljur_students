import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final Function(String)? onChanged;
  final String hintText;

  const PasswordInput({super.key, this.onChanged, required this.hintText});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: 'Password',
          suffixIcon: GestureDetector(
            child: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
            onTap: () => setState(() => hidePassword = !hidePassword),
          )),
      obscureText: hidePassword,
      enableSuggestions: false,
      autocorrect: false,
      onChanged: widget.onChanged,
    );
  }
}
