import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:mentis_ai/utils/app-colors.dart'; 

class MetricDetailScreen extends StatefulWidget {
  final String title;
  final HealthDataType healthType;
  final String unit;
  final Color color;

  const MetricDetailScreen({
    super.key,
    required this.title,
    required this.healthType,
    required this.unit,
    required this.color,
  });

  @override
  State<MetricDetailScreen> createState() => _MetricDetailScreenState();
}

class _MetricDetailScreenState extends State<MetricDetailScreen> {
  List<double> _weeklyData = List.filled(7, 0.0);
  List<String> _weekDays = [];
  String _feedbackText = "Analisando seus dados...";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDailyHistory();
  }

  Future<void> _loadDailyHistory() async {
    final Health health = Health();
    final now = DateTime.now();
    // Pega os últimos 7 dias incluindo o hoje
    final startDate = now.subtract(const Duration(days: 6));
    final startOfPeriod = DateTime(startDate.year, startDate.month, startDate.day);

    try {
      List<HealthDataPoint> data = await health.getHealthDataFromTypes(
        startTime: startOfPeriod,
        endTime: now,
        types: [widget.healthType],
      );

      data = health.removeDuplicates(data);

      List<double> dailyTotals = List.filled(7, 0.0);
      List<String> dayLabels = [];

      for (int i = 0; i < 7; i++) {
        // 0 = 6 dias atrás ... 6 = Hoje
        DateTime targetDay = startDate.add(Duration(days: i));
        dayLabels.add(DateFormat('E', 'pt_BR').format(targetDay));

        var pointsOfDay = data.where((point) {
          return point.dateTo.day == targetDay.day && 
                 point.dateTo.month == targetDay.month &&
                 point.dateTo.year == targetDay.year;
        }).toList();

        double daySum = 0.0;
        for (var p in pointsOfDay) {
          if (p.value is NumericHealthValue) {
            daySum += (p.value as NumericHealthValue).numericValue.toDouble();
          }
        }
        
        // Média para batimentos, Soma para o resto
        if (widget.healthType == HealthDataType.HEART_RATE && pointsOfDay.isNotEmpty) {
           daySum = daySum / pointsOfDay.length;
        }

        dailyTotals[i] = daySum;
      }

      // Lógica de fallback simples para BMR se vier zerado
      if (widget.healthType == HealthDataType.BASAL_ENERGY_BURNED || 
         (widget.healthType == HealthDataType.ACTIVE_ENERGY_BURNED && dailyTotals.last == 0)) {
      }

      String feedback = _generateTimeBasedInsight(dailyTotals);

      if (!mounted) return;
      setState(() {
        _weeklyData = dailyTotals;
        _weekDays = dayLabels;
        _feedbackText = feedback;
        _isLoading = false;
      });

    } catch (e) {
      print("Erro gráfico: $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _generateTimeBasedInsight(List<double> data) {
    if (data.isEmpty) return "Sem dados suficientes.";

    double todayValue = data.last;
    
    // Média dos 6 dias anteriores (histórico)
    double pastSum = 0;
    for(int i=0; i<6; i++) {
      pastSum += data[i];
    }
    double pastAverage = pastSum / 6;
    if (pastAverage == 0) pastAverage = 1; // Evita divisão por zero

    final now = DateTime.now();
    bool isEndOfDay = now.hour >= 23; // Definição de "Fim do dia"

    String metric = widget.title;
    //fim do dia 
    if (isEndOfDay) {
      if (todayValue >= pastAverage * 1.05) {
        return "Parabéns! Você fechou o dia acima da sua média semanal em $metric. Esse esforço extra faz diferença na sua evolução a longo prazo.";
      } else if (todayValue <= pastAverage * 0.85) {
        return "O dia acabou e seu registro de $metric ficou abaixo da média. Não desanime! Tente compensar amanhã com uma rotina mais ativa.";
      } else {
        return "Dia finalizado! Você manteve sua constância em $metric hoje. A regularidade é a chave para resultados sustentáveis.";
      }
    } 
    // durante o dia
    else {
       if (todayValue > pastAverage) {
         return "Incrível! Mesmo antes do dia acabar, você já superou sua média diária de $metric. Continue assim!";
       } else if (todayValue > pastAverage * 0.5) {
         return "Você está no caminho certo. Já atingiu metade da sua média habitual. Mantenha o foco para fechar o dia bem!";
       } else {
         return "Sua contagem de $metric está baixa por enquanto. Que tal aproveitar o restante do dia para se movimentar e alcançar sua meta?";
       }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 250,
                    padding: const EdgeInsets.only(right: 16, top: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          verticalInterval: 1,
                          getDrawingHorizontalLine: (value) => FlLine(color: Colors.grey.shade200, strokeWidth: 1),
                          getDrawingVerticalLine: (value) => FlLine(color: Colors.grey.shade200, strokeWidth: 1),
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                int index = value.toInt();
                                if (index >= 0 && index < _weekDays.length) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(_weekDays[index], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                  );
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: false),
                        minX: 0,
                        maxX: 6,
                        minY: 0,
                        maxY: (_weeklyData.reduce((a, b) => a > b ? a : b) * 1.2) + 1,
                        lineBarsData: [
                          LineChartBarData( 
                            spots: _weeklyData.asMap().entries.map((e) {
                              return FlSpot(e.key.toDouble(), e.value);
                            }).toList(),
                            isCurved: false,
                            color: widget.color,
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) {
                                return FlDotCirclePainter(
                                  radius: 4,
                                  color: widget.color,
                                  strokeWidth: 2,
                                  strokeColor: Colors.white,
                                );
                              },
                            ),
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 4,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "MentisAI Insight",
                          style: TextStyle(
                            fontSize: 18, 
                            fontWeight: FontWeight.bold,
                            color: Colors.black87
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _feedbackText,
                          style: const TextStyle(
                            fontSize: 15, 
                            height: 1.5, 
                            color: Colors.grey
                          ), 
                          textAlign: TextAlign.left,
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