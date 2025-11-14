import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentis_ai/screens/widgets/metrics_card.dart';
import 'package:mentis_ai/screens/widgets/date-navigator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleSignInAccount? _user;

  @override
  void initState() {
    super.initState();
    _initializeGoogleSignIn();
  }

  Future<void> _initializeGoogleSignIn() async {
    await GoogleSignIn.instance.initialize();

    // Escuta login/logout
    GoogleSignIn.instance.authenticationEvents.listen((event) {
      setState(() {
        _user = switch (event) {
          GoogleSignInAuthenticationEventSignIn() => event.user,
          GoogleSignInAuthenticationEventSignOut() => null,
        };
      });
    });
  }

  Future<void> _signIn() async {
    try {
      if (GoogleSignIn.instance.supportsAuthenticate()) {
        await GoogleSignIn.instance.authenticate(scopeHint: ['email']);
      } else {
        print('Plataforma requer UI específica para login');
      }
    } catch (e) {
      print('Erro ao autenticar: $e');
    }
  }

  Future<void> _signOut() async {
    try {
      await GoogleSignIn.instance.disconnect();
    } catch (e) {
      print('Erro ao sair: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _user?.displayName ?? "Visitante";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (_user != null)
            IconButton(
              onPressed: _signOut,
              icon: const Icon(Icons.logout, color: Colors.red),
              tooltip: "Sair",
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Olá,',
                  style: const TextStyle(fontSize: 22, color: Colors.grey)),
              Text(
                displayName,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 40),

              // Se o usuário não estiver logado, mostra botão de login
              if (_user == null)
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _signIn,
                    icon: const Icon(Icons.login),
                    label: const Text('Entrar com Google'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                  ),
                )
              else
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const DateNavigator(),
                      const SizedBox(height: 20),
                      const Text(
                        'Métricas de atividades',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const MetricsCard(
                        title: 'Calorias',
                        value: '2000',
                        unit: 'kcal',
                        icon: Icons.local_fire_department,
                      ),
                      const SizedBox(height: 8),
                      const MetricsCard(
                        title: 'Passos',
                        value: '5300',
                        unit: 'passos',
                        icon: Icons.directions_walk,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
