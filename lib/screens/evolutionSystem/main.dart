import 'package:flutter/material.dart';
import 'package:mentis_ai/screens/widgets/evolution-cards.dart';
import 'package:mentis_ai/screens/widgets/evolution-line-chart.dart';
import 'package:fl_chart/fl_chart.dart';

class EvolutionSystem extends StatelessWidget {
  const EvolutionSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            children: [
              //Título
              Center(
                child: Text(
                  'Evolução',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              EvolutionLineChart(
                dataSpots: const [
                  FlSpot(0, 10.0),
                  FlSpot(1, 17.5),
                  FlSpot(2, 25.0),
                ],
                // Rótulos correspondentes ao eixo X
                bottomLabels: const [
                  '8 de jul.',
                  '9 de jul.',
                  '10 de jul.',
                ],
                // O valor mais alto na escala Y (25 mil)
                maxYValue: 25.0,
              ),

              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20.0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 20.0,
                padding: EdgeInsets.all(12.0),
                children: [
                  EvolutionCards(
                      title: 'Freq. Cardíaca', icon: Icons.heart_broken),
                  EvolutionCards(title: 'Passos', icon: Icons.directions_walk),
                  EvolutionCards(title: 'Sono', icon: Icons.bed),
                  EvolutionCards(
                      title: 'Freq. Cardíaca',
                      icon: Icons.local_fire_department),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
