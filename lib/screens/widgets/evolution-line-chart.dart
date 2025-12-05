import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EvolutionLineChart extends StatelessWidget {
  // Lista de pontos de dados: FlSpot(X, Y)
  final List<FlSpot> dataSpots; 
  // Rótulos do eixo X (ex: '8 de jul.', '9 de jul.', etc.)
  final List<String> bottomLabels; 
  // O valor máximo do eixo Y
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
      // --- GRADE E BORDAS ---
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: true,
        // Cor cinza clara para as linhas da grade, como no seu design
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

      // --- TÍTULOS DOS EIXOS ---
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(),
        topTitles: const AxisTitles(),
        
        // Títulos do Eixo X (Datas)
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            // showTotal: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: getBottomTitles, // Função para formatar as datas
          ),
        ),
        
        // Títulos do Eixo Y (Valores)
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            // showTotal: true,
            // 5 divisões: 0, 5mil, 10mil, 15mil, 20mil, 25mil
            interval: maxYValue / 5, 
            getTitlesWidget: getLeftTitles, // Função para formatar o texto (ex: '10 mil')
            reservedSize: 40,
          ),
        ),
      ),
      
      // --- LIMITES DO GRÁFICO ---
      minX: 0,
      maxX: dataSpots.length.toDouble() - 1, // X vai de 0 até o último ponto
      minY: 0,
      maxY: maxYValue, // Usa o valor máximo passado (ex: 25)
      
      // --- CONFIGURAÇÃO DA LINHA ---
      lineBarsData: [
        LineChartBarData(
          spots: dataSpots, 
          isCurved: false, // Linha reta
          barWidth: 3,
          color: Colors.deepPurple, // Cor roxa/azul, como no seu gráfico
          dotData: const FlDotData(show: true), // Mostra os pontos nos dados
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
    // Formata o valor com 'mil'
    if (value == 0) {
      text = '0';
    } else if (value.toInt() % (maxYValue ~/ 5) == 0) {
      // Divide por 1000 e formata com " mil"
      text = '${value.toInt()} mil'; 
    } else {
      return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.right);
  }

  // Função para formatar os labels do Eixo X (Datas)
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