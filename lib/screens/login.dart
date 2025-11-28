import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:credential_manager/credential_manager.dart' hide User;
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String senha = '';
  bool _isPasswordVisible = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  final CredentialManager _credentialManager = CredentialManager();

  Future<void> _handleGoogleSignIn() async {
    try {
      setState(() {
        _isLoading = true;
      });

      // Passo A: Inicializar o Credential Manager (Necessário no Android)
      // O 'googleClientId' deve ser o seu "ID do cliente da Web" do Console do Google Cloud/Firebase.
      await _credentialManager.init(
        preferImmediatelyAvailableCredentials: true,
        googleClientId:
            '409331129900-9stgkk1gpq625kbetlv6s5avqb3fke0s.apps.googleusercontent.com',
      );

      final GoogleIdTokenCredential? result =
          await _credentialManager.saveGoogleCredential();
      if (result == null) {
        // Usuário cancelou o login
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // // Obter a autenticação
      final credential = GoogleAuthProvider.credential(
        idToken: result.idToken,
        accessToken: null, // O accessToken pode ser nulo
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Pegue o usuário real do Firebase
      final User? firebaseUser = userCredential.user;

      // Print correto
      print(
          'Usuário logado com sucesso: ${firebaseUser?.displayName ?? firebaseUser?.email}');
    } catch (e) {
      print('Erro durante o login com Credential Manager: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro no login: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleEmailSignIn() async {
    try {
      if (email.isEmpty || senha.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor, preencha email e senha'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      print('Login com email realizado com sucesso');
    } catch (e) {
      print('Erro durante o login com email: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro no login: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
                // Logo MentisAI
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo_mentisAI.png',
                        height: 300.0,
                        width: 300.0,
                      ),
                    ],
                  ),
                ),

                // Campo de email
                const Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      email = text;
                    });
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Digite seu email...',
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

                // Campo de senha
                const Text(
                  'Senha',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      senha = text;
                    });
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
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 2.0,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
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
                      // Implementar recuperação de senha
                    },
                    child: const Text(
                      'Esqueceu sua Senha?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Botão de entrar com email
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleEmailSignIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
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

                const Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('ou', style: TextStyle(color: Colors.blue)),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),

                const SizedBox(height: 30),

                // Botão Entrar com o Google - CORRIGIDO
                SizedBox(
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: _isLoading
                        ? null
                        : _handleGoogleSignIn, // ← Este é o método que estava faltando
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    icon: Image.asset(
                      'assets/images/google-icon.png',
                      height: 20.0,
                    ),
                    label: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
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
