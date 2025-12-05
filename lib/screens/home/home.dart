import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentis_ai/screens/evolutionSystem/main.dart';
import 'package:mentis_ai/screens/screeningSystem/screening_system.dart';
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

  static final List<Widget> _screenOptions = <Widget>[
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
      body: _screenOptions.elementAt(_selectedIndex),
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
                const DateNavigator(),
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
                      value: '2000',
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
                      value: '5300',
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
                  duration: '6H',
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
