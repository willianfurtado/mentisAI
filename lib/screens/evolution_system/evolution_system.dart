import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health/health.dart'; 
import 'package:mentis_ai/screens/widgets/evolution_system/evolution_cards.dart';
import 'package:mentis_ai/screens/evolution_system/metric_details_screen.dart'; 

class EvolutionSystem extends StatefulWidget {
  const EvolutionSystem({super.key});

  @override
  State<EvolutionSystem> createState() => _EvolutionSystemState();
}

class _EvolutionSystemState extends State<EvolutionSystem> {
  String _avgSteps = "--";
  String _avgCalories = "--";
  String _avgHeartRate = "--";
  String _avgSleep = "--";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWeeklyData();
  }

  Future<void> _loadWeeklyData() async {
    final Health health = Health();
    final now = DateTime.now();
    final startDate = now.subtract(const Duration(days: 7));

    var types = [
      HealthDataType.STEPS,
      HealthDataType.ACTIVE_ENERGY_BURNED,
      HealthDataType.BASAL_ENERGY_BURNED,
      HealthDataType.HEART_RATE,
      HealthDataType.SLEEP_SESSION,
    ];

    try {
      List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
        startTime: startDate,
        endTime: now,
        types: types,
      );

      healthData = health.removeDuplicates(healthData);

      double totalBasal = 0.0;
      double totalActive = 0.0;
      int totalSteps = 0;
      int totalHeartRate = 0;
      int heartRateCount = 0;
      int totalSleepMinutes = 0;

      for (var point in healthData) {
        if (point.value is NumericHealthValue) {
          final val = (point.value as NumericHealthValue).numericValue;

          if (point.type == HealthDataType.STEPS) {
            totalSteps += val.toInt();
          } else if (point.type == HealthDataType.ACTIVE_ENERGY_BURNED) {
            totalActive += val.toDouble();
          } else if (point.type == HealthDataType.BASAL_ENERGY_BURNED) {
            totalBasal += val.toDouble();
          } else if (point.type == HealthDataType.HEART_RATE) {
            totalHeartRate += val.toInt();
            heartRateCount++;
          } else if (point.type == HealthDataType.SLEEP_SESSION) {
            totalSleepMinutes += val.toInt();
          }
        }
      }

      if (totalBasal < 1000) {
        totalBasal = 1.2 * 1440 * 7; 
      }

      int avgSteps = (totalSteps / 7).round();
      int avgCalories = ((totalBasal + totalActive) / 7).round();
      int avgBpm = heartRateCount > 0 ? (totalHeartRate / heartRateCount).round() : 0;
      int avgSleepMin = (totalSleepMinutes / 7).round();
      
      String avgSleepStr = "--";
      if (avgSleepMin > 0) {
        avgSleepStr = "${avgSleepMin ~/ 60}h ${avgSleepMin % 60}m";
      }

      if (!mounted) return;

      setState(() {
        _avgSteps = avgSteps.toString();
        _avgCalories = avgCalories.toString();
        _avgHeartRate = avgBpm > 0 ? avgBpm.toString() : "--";
        _avgSleep = avgSleepStr;
        _isLoading = false;
      });

    } catch (e) {
      print("Erro Evolução: $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            children: [
              const Text(
                'Evolução',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text("Média Semanal", style: TextStyle(color: Colors.grey)), // Subtítulo opcional

              const SizedBox(height: 40),

              _isLoading 
               ? const Center(child: CircularProgressIndicator())
               : GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20.0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 20.0,
                padding: const EdgeInsets.all(6.0),
                childAspectRatio: 1.0, // Quadrado
                children: [
                  
                  EvolutionCards(
                    title: 'Freq. Cardíaca',
                    value: _avgHeartRate, 
                    unit: 'bpm',
                    iconWidget: SvgPicture.asset('assets/images/heart-white.svg'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MetricDetailScreen(
                        title: "Frequência Cardíaca",
                        healthType: HealthDataType.HEART_RATE,
                        unit: "bpm",
                        color: Colors.redAccent,
                      )));
                    },
                  ),

                  EvolutionCards(
                    title: 'Sono',
                    value: _avgSleep,
                    unit: 'média/noite',
                    iconWidget: SvgPicture.asset('assets/images/moon-white.svg'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MetricDetailScreen(
                        title: "Sono",
                        healthType: HealthDataType.SLEEP_SESSION,
                        unit: "min",
                        color: Colors.indigoAccent,
                      )));
                    },
                  ),

                  EvolutionCards(
                    title: 'Calorias',
                    value: _avgCalories,
                    unit: 'kcal',
                    iconWidget: SvgPicture.asset('assets/images/fire-white.svg'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MetricDetailScreen(
                        title: "Calorias Queimadas",
                        healthType: HealthDataType.ACTIVE_ENERGY_BURNED,
                        unit: "kcal",
                        color: Colors.orange,
                      )));
                    },
                  ),

                  EvolutionCards(
                    title: 'Passos',
                    value: _avgSteps,
                    unit: 'passos',
                    iconWidget: SvgPicture.asset('assets/images/walk-white.svg'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MetricDetailScreen(
                        title: "Passos",
                        healthType: HealthDataType.STEPS,
                        unit: "passos",
                        color: Colors.blueAccent, 
                      )));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}