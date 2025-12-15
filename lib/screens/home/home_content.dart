import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentis_ai/services/database_service.dart';
import 'package:mentis_ai/models/metric_data.dart';
import 'package:mentis_ai/screens/widgets/home/date_navigator.dart';
import 'package:mentis_ai/screens/widgets/home/metrics_card.dart';
import 'package:mentis_ai/screens/widgets/home/metrics_card_heart.dart';
import 'package:mentis_ai/screens/widgets/home/rainbow_progress_indicator.dart';
import 'package:mentis_ai/screens/widgets/home/sleep_card.dart';
import 'package:mentis_ai/screens/widgets/home/sleep_quality_card.dart';
import 'package:mentis_ai/utils/app-colors.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  DateTime _currentDate = DateTime.now()
      .toUtc()
      .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
  MetricData? _dailyMetrics;
  final dbService = DataBaseService();

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await dbService.seedDatabase();
    await _loadMetricsForDate(_currentDate);
  }

  Future<void> _loadMetricsForDate(DateTime date) async {
    final dateString = date.toIso8601String().split('T').first;
    final data = await dbService.getMetricByDate(dateString);
    setState(() {
      _dailyMetrics = data;
      _currentDate = date;
    });
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
    final stepsValue = _dailyMetrics?.steps ?? 0;
    final caloriesValue = _dailyMetrics?.calories ?? 0;
    final sleepDuration = _dailyMetrics != null ? '6H' : '--';
    final sleepQualityValue = _dailyMetrics?.sleepQuality ?? 0.0;

    final List<double> progressValues = [0.8, 0.7, 0.5, 0.4];
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
          const Text(
            'Olá,',
            style: TextStyle(fontSize: 22, color: Colors.grey),
          ),
          const Text(
            'Willian',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 40),

          // Conteúdo da Home
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
                    values: progressValues,
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
                      value: caloriesValue.toString(),
                      unit: 'kcal',
                      iconWidget: SvgPicture.asset(
                        'assets/images/fire.svg',
                        height: 30,
                      ),
                    ),
                    MetricsCardHeart(
                      title: 'Frequência Cardíaca',
                      value: '96',
                      unit: 'bpm',
                      icon: SvgPicture.asset(
                        'assets/images/heart-pulse.svg',
                        height: 30,
                      ),
                      chartData: const [80, 75, 90, 85, 96, 92],
                    ),
                    MetricsCard(
                      title: 'Passos',
                      value: stepsValue.toString(),
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
                  duration: sleepDuration,
                  iconWidget: SvgPicture.asset(
                    'assets/images/moon.svg',
                    height: 18,
                  ),
                ),
                const SizedBox(height: 10),
                const SleepQualityCard(
                    title: 'Qualidade do Sono',
                    qualityOfSleepData: [0.2, 0.3, .4, .3, .6, .4, .8])
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
