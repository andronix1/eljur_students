import 'package:eljur_students/dependency_injection.dart';
import 'package:eljur_students/features/eljur_auth/domain/entities/account_entity.dart';
import 'package:eljur_students/features/eljur_auth/presentation/bloc/auth_bloc.dart';
import 'package:eljur_students/features/eljur_auth/presentation/widgets/password_input.dart';
import 'package:eljur_students/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String username = '', password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => locator<AuthBloc>(),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthDataLoaded) {
                Navigator.pushNamed(context, Routes.mainPageRoute);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Authentication',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 40),
                      TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Username',
                        ),
                        onChanged: (value) => username = value,
                      ),
                      const SizedBox(height: 10),
                      PasswordInput(
                        onChanged: (value) => password = value,
                        hintText: 'Password',
                      ),
                      const SizedBox(height: 10),
                      if (state is AuthDataInvalidCredentialsError)
                        const Text(
                          'invalid credentials',
                          style: TextStyle(color: Colors.red),
                        ),
                      if (state is AuthDataServerError)
                        const Text(
                          'server error',
                          style: TextStyle(color: Colors.red),
                        ),
                      ElevatedButton(
                        onPressed: () => BlocProvider.of<AuthBloc>(context).add(
                          AuthLoginEvent(
                            authInfo: AuthInfo(
                              username: username,
                              password: password,
                            ),
                          ),
                        ),
                        child: state is AuthDataLoading
                            ? Transform.scale(
                                scale: 0.8,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Login'),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
