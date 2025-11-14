import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentis_ai/screens/login.dart';
import 'package:mentis_ai/screens/widgets/metrics_card.dart';
import 'package:mentis_ai/screens/widgets/date-navigator.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  // Função de logout (Google + Firebase)
  Future<void> _signOut(BuildContext context) async {
    try {
      // Deslogar do Google
      await GoogleSignIn().signOut();

      // Deslogar do Firebase
      await FirebaseAuth.instance.signOut();

      // Redirecionar para a tela de login
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Login()),
        (route) => false,
      );
    } catch (e) {
      print('Erro ao deslogar: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao sair da conta. Tente novamente.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('MentisAI'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () => _signOut(context),
            tooltip: 'Sair',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Olá,', style: TextStyle(fontSize: 22, color: Colors.grey)),
              Text(
                user?.displayName ?? 'Usuário',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 47),
              DateNavigator(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Métricas de atividades',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  MetricsCard(
                    title: 'Calorias',
                    value: '2000',
                    unit: 'kcal',
                    icon: Icons.local_fire_department,
                  ),
                  SizedBox(height: 8),
                  MetricsCard(
                    title: 'Passos',
                    value: '5000',
                    unit: 'passos',
                    icon: Icons.directions_walk,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
