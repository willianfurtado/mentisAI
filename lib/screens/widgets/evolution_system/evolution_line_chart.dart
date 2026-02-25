import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EvolutionLineChart extends StatelessWidget {
  final List<FlSpot> dataSpots; 
  final List<String> bottomLabels; 
  final double maxYValue; 

  const EvolutionLineChart({
    super.key,
    required this.dataSpots,
    required this.bottomLabels,
    required this.maxYValue,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7, 
      child: Padding(
        padding: const EdgeInsets.only(right: 18, left: 12, top: 24, bottom: 12),
        child: LineChart(
          mainData(),
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) => FlLine(
          color: Colors.grey.withOpacity(0.3),
          strokeWidth: 1,
        ),
        getDrawingVerticalLine: (value) => FlLine(
          color: Colors.grey.withOpacity(0.3),
          strokeWidth: 1,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),

      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(),
        topTitles: const AxisTitles(),
        
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            // showTotal: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: getBottomTitles, 
          ),
        ),
        
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            interval: maxYValue / 5, 
            getTitlesWidget: getLeftTitles,
            reservedSize: 40,
          ),
        ),
      ),
      
      minX: 0,
      maxX: dataSpots.length.toDouble() - 1, 
      minY: 0,
      maxY: maxYValue, 
      
      lineBarsData: [
        LineChartBarData(
          spots: dataSpots, 
          isCurved: false, 
          barWidth: 3,
          color: Colors.deepPurple, 
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(show: false),
        ),
      ],
    );
  }

  Widget getLeftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
      color: Colors.grey,
    );
    String text;
    if (value == 0) {
      text = '0';
    } else if (value.toInt() % (maxYValue ~/ 5) == 0) {
      text = '${value.toInt()} mil'; 
    } else {
      return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.right);
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
      color: Colors.grey,
    );
    
    Widget text;
    final index = value.toInt();
    
    if (index >= 0 && index < bottomLabels.length) {
      text = Text(bottomLabels[index], style: style);
    } else {
      text = const Text('');
    }
    
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: text,
    );
  }

}