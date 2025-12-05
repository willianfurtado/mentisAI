import 'package:flutter/material.dart';
import 'package:mentis_ai/screens/widgets/evolution-cards.dart';
import 'package:mentis_ai/screens/widgets/evolution-line-chart.dart';
import 'package:fl_chart/fl_chart.dart';

class EvolutionSteps extends StatelessWidget {

  const EvolutionSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.chevron_left),
                  const Text(
                    'Passos',
                    style: TextStyle(
                      
                    ),
                  ),
                ],
              ),
              EvolutionLineChart(
                dataSpots: [
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
            ],
          ),
        ), 
      ),
    );
  }
}