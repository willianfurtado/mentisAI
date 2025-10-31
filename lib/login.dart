import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String senha = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 40.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Logo MentisAI
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo_mentisAI.png',
                        height: 300.0,
                        width: 300.0,
                      ),
                      // const SizedBox(height: 10),
                      // const Text(),
                      // const SizedBox(height: 50),
                    ],
                  ),
                ),

                //Campo de email

                //Campo de senha
              ],
            ),
          ),
        ),
      ),
    );
  }
}
