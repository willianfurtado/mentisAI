import 'package:flutter/material.dart';
import 'package:mentis_ai/screens/widgets/metrics_card.dart';
import 'package:mentis_ai/screens/widgets/date-navigator.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Olá,', style: TextStyle(fontSize: 22, color: Colors.grey)),
              Text(
                'Willian',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 47),
              DateNavigator(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Métricas de atividades',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  MetricsCard(
                    title: 'Calorias',
                    value: '2000',
                    unit: 'kcal',
                    icon: Icons.local_fire_department,
                  ),
                  const SizedBox(height: 8),
                  MetricsCard(
                    title: 'Calorias',
                    value: '2000',
                    unit: 'kcal',
                    icon: Icons.local_fire_department,
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
