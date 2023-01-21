import 'package:eljur_students/dependency_injection.dart';
import 'package:eljur_students/features/eljur_auth/domain/entities/account_entity.dart';
import 'package:eljur_students/features/eljur_auth/presentation/bloc/auth_bloc.dart';
import 'package:eljur_students/features/eljur_auth/presentation/widgets/password_input.dart';
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
          create: (context) => AuthBloc(loginUseCase: sl()),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Authentication',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                    if (state is AuthDataLoaded)
                      const Text(
                        'authenticated)',
                        style: TextStyle(color: Colors.green),
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
                          ? const CircularProgressIndicator()
                          : const Text('Login'),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
