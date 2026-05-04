import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mentis_ai/screens/widgets/Home/date_navigator.dart';
import 'package:mentis_ai/screens/widgets/Home/metrics_card.dart';
import 'package:mentis_ai/screens/widgets/Home/metrics_card_heart.dart';
import 'package:mentis_ai/screens/widgets/Home/rainbow_progress_indicator.dart';
import 'package:mentis_ai/screens/widgets/Home/sleep_card.dart';
import 'package:mentis_ai/screens/widgets/Home/sleep_quality_card.dart';
import 'package:mentis_ai/utils/app-colors.dart';

class HomeContent extends StatefulWidget {
  final Function({
    required int steps, 
    required double calories, 
    required int heartRate, 
    required int sleepMinutes
  }) onDataLoaded;

  const HomeContent({super.key, required this.onDataLoaded});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  DateTime _currentDate = DateTime.now();
  
  String _steps = "0";
  String _calories = "0"; 
  String _heartRate = "--";
  String _sleepDuration = "--";

  List<double> _progressValues = [0.0, 0.0, 0.0, 0.0];

  final double _goalSteps = 6000;
  final double _goalCalories = 2000;
  final double _goalSleepMinutes = 480; 

  @override
  void initState() {
    super.initState();
    _initHealthFlow();
  }

  Future<void> _initHealthFlow() async {
    var status = await Permission.activityRecognition.status;
    if (!status.isGranted) {
       await Permission.activityRecognition.request();
    }
    
    await _loadMetricsForDate(_currentDate);
  }

  Future<void> _loadMetricsForDate(DateTime date) async {
    final Health health = Health();

    final startTime = DateTime(date.year, date.month, date.day);
    final now = DateTime.now();
    final isToday = date.year == now.year && date.month == now.month && date.day == now.day;
    final endTime = isToday ? now : DateTime(date.year, date.month, date.day, 23, 59, 59);

    var types = [
      HealthDataType.STEPS,
      HealthDataType.ACTIVE_ENERGY_BURNED,
      HealthDataType.BASAL_ENERGY_BURNED, 
      HealthDataType.HEART_RATE,
      HealthDataType.SLEEP_SESSION,
      // Separar estágios do sono
      HealthDataType.SLEEP_AWAKE,
      HealthDataType.SLEEP_REM,
      HealthDataType.SLEEP_LIGHT,
      HealthDataType.SLEEP_DEEP,
    ];

    try {
      await health.requestAuthorization(types);

      List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
        startTime: startTime,
        endTime: endTime,
        types: types,
      );

      healthData = health.removeDuplicates(healthData);

      double basal = 0.0;
      double active = 0.0;
      int stepsTotal = 0;
      int lastHeartRate = 0;
      int sleepMinutes = 0;

      for (var point in healthData) {
        if (point.value is NumericHealthValue) {
          final val = (point.value as NumericHealthValue).numericValue;

          if (point.type == HealthDataType.STEPS) {
            stepsTotal += val.toInt();
          } 
          else if (point.type == HealthDataType.ACTIVE_ENERGY_BURNED) {
            active += val.toDouble();
          }
          else if (point.type == HealthDataType.BASAL_ENERGY_BURNED) {
            basal += val.toDouble();
          }
          else if (point.type == HealthDataType.HEART_RATE) {
            lastHeartRate = val.toInt();
          }
          else if (point.type == HealthDataType.SLEEP_SESSION) {
             sleepMinutes += val.toInt();
          }
        }
      }

      if (basal == 0 && isToday) {
         int minutesPassed = now.difference(startTime).inMinutes;
         if (minutesPassed > 0 && minutesPassed < 1440) {
            basal = minutesPassed * 1.2; 
         }
      }

      String sleepStr = "--";
      if (sleepMinutes > 0) {
        final hours = sleepMinutes ~/ 60;
        final mins = sleepMinutes % 60;
        sleepStr = "${hours}h ${mins}m";
      }

      int totalCalories = (basal + active).toInt();

      double stepProgress = (stepsTotal / _goalSteps).clamp(0.0, 1.0);
      double calProgress = (totalCalories / _goalCalories).clamp(0.0, 1.0);
      double sleepProgress = (sleepMinutes / _goalSleepMinutes).clamp(0.0, 1.0);
      double heartProgress = 0.0;
      if (lastHeartRate > 0) {
        heartProgress = ((lastHeartRate - 40) / (120 - 40)).clamp(0.0, 1.0);
      }

      if (!mounted) return;

      setState(() {
        _currentDate = date;
        _steps = stepsTotal.toString();
        _calories = totalCalories.toString();
        _heartRate = lastHeartRate > 0 ? lastHeartRate.toString() : "--";
        _sleepDuration = sleepStr;
        _progressValues = [stepProgress, calProgress, sleepProgress, heartProgress];
      });

      //mod
      widget.onDataLoaded(
        steps: stepsTotal,
        calories: totalCalories.toDouble(),
        heartRate: lastHeartRate,
        sleepMinutes: sleepMinutes,
      );
      print("HomeContent -> Passos: $_steps, Cal: $_calories (Basal: ${basal.toInt()})");

    } catch (e) {
      print("Erro Health: $e");
    }
  }

  void _goToPreviousDay() {
    final previousDay = _currentDate.subtract(const Duration(days: 1));
    _loadMetricsForDate(previousDay);
  }

  void _goToNextDay() {
    final nextDay = _currentDate.add(const Duration(days: 1));
    if (nextDay.isAfter(DateTime.now())) return;
    _loadMetricsForDate(nextDay);
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    String primeiroNome = "Visitante";
    if (user != null && user.displayName != null) {
      primeiroNome = user.displayName!.split(' ').first;
    }

    final List<Color> arcColors = [
      AppColors.blue800,
      AppColors.supportGreen2,
      AppColors.blue700,
      AppColors.supportGreen2,
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Olá, $primeiroNome",
              style: const TextStyle(fontSize: 24, color: Colors.grey),
            ),
            const SizedBox(height: 40),

            Expanded(
              child: ListView(
                children: [
                  DateNavigator(
                    currentDate: _currentDate,
                    onPreviousDay: _goToPreviousDay,
                    onNextDay: _goToNextDay,
                  ),
                  const SizedBox(height: 40),
                  
                  Center(
                    child: RainbowProgressIndicator(
                      values: _progressValues, 
                      colors: arcColors,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  const Text(
                    'Métricas de atividades',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.9,
                    children: [
                      MetricsCard(
                        title: 'Calorias',
                        value: _calories, 
                        unit: 'kcal',
                        iconWidget: SvgPicture.asset(
                          'assets/images/fire.svg',
                          height: 30,
                        ),
                      ),
                      MetricsCardHeart(
                        title: 'Freq Cardíaca',
                        value: _heartRate,
                        unit: 'bpm',
                        icon: SvgPicture.asset(
                          'assets/images/heart-pulse.svg',
                          height: 30,
                        ),
                        chartData: const [80, 75, 90, 85, 96, 92],
                      ),
                      MetricsCard(
                        title: 'Passos',
                        value: _steps,
                        unit: 'passos',
                        iconWidget: SvgPicture.asset(
                          'assets/images/person-walking.svg',
                          height: 30,
                        ),
                      ),
                      const SizedBox.shrink(),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  const Text(
                    'Dados do sono',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  
                  SleepCard(
                    title: 'Sono',
                    duration: _sleepDuration,
                    iconWidget: SvgPicture.asset(
                      'assets/images/moon.svg',
                      height: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SleepQualityCard(
                      title: 'Qualidade do Sono',
                      qualityOfSleepData: [0.2, 0.3, .4, .3, .6, .4, .8]
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}