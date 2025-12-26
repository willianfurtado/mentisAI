import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mentis_ai/utils/app-colors.dart'; 

class HeartRateBarChart extends StatelessWidget {
  final List<double> heartRateData; 

  const HeartRateBarChart({
    super.key,
    required this.heartRateData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80, 
      width: double.infinity, 
      child: BarChart(
        mainBarData(),
      ),
    );
  }

  BarChartData mainBarData() {
    const double maxYValue = 120;
    
    return BarChartData(
      
      barTouchData: BarTouchData(enabled: false), 
      titlesData: const FlTitlesData(show: false), 
      borderData: FlBorderData(show: false),      
      gridData: const FlGridData(show: false),      
      
      minY: 0, //base do gráfico iniciando no ponto zero 
      maxY: maxYValue, //limite que o eixo vertical irá alcançar (120 unidades -> 120bpm)

      barGroups: heartRateData.asMap().entries.map((entry) {
        final index = entry.key;
        final value = entry.value;

        return BarChartGroupData(
          x: index, 
          barRods: [
            BarChartRodData(
              toY: value, 
              color: AppColors.blue700, 
              width: 10, 
              borderRadius: BorderRadius.circular(4), 
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: maxYValue, 
                color: Colors.grey.withOpacity(0.2), 
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}