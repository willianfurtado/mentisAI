import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SleepQualityBarChart extends StatelessWidget {
  final List<double> qualityData;
  const SleepQualityBarChart({super.key, required this.qualityData});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.5, // Ajuste a proporção para o tamanho desejado
      child: BarChart(
        mainBarData(),
      ),
    );
  }

  BarChartData mainBarData() {
    //O valor máximo é 1.0 (100% de qualidade)
    const double maxYValue = 1.0;

    return BarChartData(
      barTouchData: BarTouchData(enabled: false),
      titlesData: const FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      gridData: const FlGridData(show: false),
      minY: 0,
      maxY: maxYValue,
      barGroups: qualityData.asMap().entries.map((entry) {
        final index = entry.key;
        final value = entry.value;

        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: value,
              color: const Color(0xFF004D40),
              width: 15,
              borderRadius: BorderRadius.circular(7),
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: maxYValue, // Ocupa 100% da altura total
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
