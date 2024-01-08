import 'package:eljur_students/features/auth/presentation/screens/token_auth/token_auth_state.dart';
import 'package:flutter/material.dart';

class TokenAuthMainScreen extends StatefulWidget {
  final TokenAuthErrorState? error;
  final void Function(String token, DateTime expiresIn)? auth;

  const TokenAuthMainScreen({super.key, this.error, this.auth});

  @override
  State<TokenAuthMainScreen> createState() => _TokenAuthMainScreenState();
}

class _TokenAuthMainScreenState extends State<TokenAuthMainScreen> {
  final TextEditingController tokenInputController = TextEditingController();
  DateTime _dateTime = DateTime.now();

  @override
  void dispose() {
    super.dispose();
    tokenInputController.dispose();
  }

  void _auth() {
    widget.auth?.call(tokenInputController.text, _dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.error != null)
          switch (widget.error!) {
            TokenAuthStringErrorState(message: var message) =>
              Text("error: $message"),
            TokenAuthUnknownErrorState() => const Text("unknown error"),
          },
        TextField(controller: tokenInputController),
        ElevatedButton(
            onPressed: () => showDatePicker(
                        currentDate: _dateTime,
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 366)))
                    .then((value) {
                  if (value != null) {
                    _dateTime = value;
                  }
                }),
            child: const Text("select date")),
        ElevatedButton(onPressed: _auth, child: const Text("auth"))
      ],
    );
  }
}
