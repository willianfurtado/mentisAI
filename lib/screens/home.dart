import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart'; //usando Firebase agora no Home;
import 'package:mentis_ai/screens/widgets/metrics_card.dart';
import 'package:mentis_ai/screens/widgets/date-navigator.dart';
import 'package:mentis_ai/screens/widgets/rainbow-progress-indicator.dart';
import 'package:mentis_ai/utils/app-colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Método simples para deslogar
  // Future<void> _signOut() async {
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //   } catch (e) {
  //     print('Erro ao sair: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser;

    // Pega o nome ou usa um padrão dependendo se o usuário está logado;
    // final displayName = user?.displayName ?? "Visitante";

    final List<double> progressValues = [0.8, 0.7, 0.5, 0.4, 0.2];

    // As cores para cada arco (de fora para dentro)
    final List<Color> arcColors = [
      AppColors.supportGreen1, // Exemplo de cor verde escura
      AppColors.supportGreen2, // Exemplo de cor verde
      const Color(0xFF00BFFF), // Exemplo de cor azul
      const Color(0xFF3CB371), // Exemplo de cor verde
      const Color(0xFF90EE90), // Exemplo de cor verde clara
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // actions: [
        //   IconButton(
        //     // onPressed: _signOut,
        //     icon: const Icon(Icons.logout, color: Colors.red),
        //     tooltip: "Sair",
        //   ),
        // ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Olá,',
                style: TextStyle(fontSize: 22, color: Colors.grey),
              ),
              Text(
                'Willian',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 40),

              // Conteúdo da Home
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DateNavigator(),
                    const SizedBox(height: 20),
                    Center(
                      child: RainbowProgressIndicator(
                        values: progressValues,
                        colors: arcColors,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Métricas de atividades',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
