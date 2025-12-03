import 'package:flutter/material.dart';
import 'package:mentis_ai/screens/evolution_system.dart';
import 'package:mentis_ai/screens/screening_system.dart';
// import 'package:mentis_ai/screens/widgets/heart-rate-bar-char.dart';
import 'package:mentis_ai/screens/widgets/bottom-navbar.dart';
import 'package:mentis_ai/screens/widgets/metrics_card-heart.dart';
import 'package:mentis_ai/screens/widgets/metrics_card.dart';
import 'package:mentis_ai/screens/widgets/date-navigator.dart';
import 'package:mentis_ai/screens/widgets/rainbow-progress-indicator.dart';
import 'package:mentis_ai/screens/widgets/sleep-card.dart';
import 'package:mentis_ai/screens/widgets/sleep-quality-card.dart';
import 'package:mentis_ai/utils/app-colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeContent(),
    const EvolutionSystem(),
    const ScreeeningSystem(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final List<double> progressValues = [0.8, 0.7, 0.5, 0.4, 0.2];
    // As cores para cada arco (de fora para dentro)
    final List<Color> arcColors = [
      AppColors.supportGreen1,
      AppColors.supportGreen2,
      const Color(0xFF00BFFF),
      const Color(0xFF3CB371),
      const Color(0xFF90EE90),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Olá,',
            style: TextStyle(fontSize: 22, color: Colors.grey),
          ),
          Text(
            'Willian',
            style: const TextStyle(
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
                const DateNavigator(),
                const SizedBox(height: 20),
                Center(
                  child: RainbowProgressIndicator(
                    values: progressValues,
                    colors: arcColors,
                  ),
                ),
                const SizedBox(height: 20),
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
                    const MetricsCard(
                      title: 'Calorias',
                      value: '2000',
                      unit: 'kcal',
                      icon: Icons.local_fire_department,
                    ),
                    const MetricsCardHeart(
                      title: 'Frequência Cardíaca',
                      value: '96',
                      unit: 'bpm',
                      icon: Icons.favorite,
                      chartData: [80, 75, 90, 85, 96, 92],
                    ),
                    const MetricsCard(
                      title: 'Passos',
                      value: '5300',
                      unit: 'passos',
                      icon: Icons.directions_walk,
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
                SleepCard(title: 'Sono'),
                const SizedBox(height: 10),
                SleepQualityCard(
                    title: 'Qualidade do Sono',
                    qualityOfSleepData: [0.2, 0.3, .4, .3, .6, .4, .8])
              ],
            ),
          ),
        ],
      ),
    );
  }
}
