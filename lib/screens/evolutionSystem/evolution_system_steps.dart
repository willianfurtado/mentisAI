import 'package:flutter/material.dart';
import 'package:mentis_ai/screens/widgets/EvolutionSystem/evolution_cards.dart';
import 'package:mentis_ai/screens/widgets/EvolutionSystem/evolution_insight.dart';
import 'package:mentis_ai/screens/widgets/EvolutionSystem/evolution_line_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mentis_ai/utils/app-colors.dart';

class EvolutionSystemSteps extends StatelessWidget {
  const EvolutionSystemSteps({super.key});

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
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      color: AppColors.black900,
                      size: 30,
                    ),
                    onPressed: () => {Navigator.pop(context)},
                  ),
                  const SizedBox(
                    width: 105,
                  ),
                  const Text(
                    'Passos',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
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

              const SizedBox(
                height: 20,
              ),

              //container do insight
              EvolutionInsight(),
            ],
          ),
        ),
      ),
    );
  }
}
