import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String senha = '';
  bool _isPasswordVisible = false;

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
                const Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextField(
                  onChanged: (text) {
                    email = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText:
                        'Digite seu email...', // Placeholder como no protótipo
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 10.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                //Campo de senha
                const Text(
                  'Senha',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                TextField(
                  onChanged: (text) {
                    senha = text;
                  },
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Digite sua senha...',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 10.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      //Implementar recuperação de senha
                    },
                    child: Text(
                      'Esqueceu sua Senha?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //Botão de entrar
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      //Implementar lógica de login
                      print('Email: $email, Senha: $senha');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 10.0),
                      child: Text('ou', style: TextStyle(color: Colors.blue)),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),

                // const SizedBox(height: 30),

                // 7. Botão Entrar com o Google
                SizedBox(
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Lógica de login com Google
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87, 
                      backgroundColor: Colors.white, 
                      side: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                      ),
                    ),
                    // icon: Image.asset(
                    //   'assets/images/google-icon.svg',
                    //   height: 20.0,
                    // ),
                    label: const Text(
                      'Entrar com o Google',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
