import 'package:flutter/material.dart';
import 'package:mentis_ai/screens/evolution_system/evolution_system.dart';
import 'package:mentis_ai/screens/home/home_content.dart';
import 'package:mentis_ai/screens/screening_system/screening_system.dart';
import 'package:mentis_ai/screens/user_profile/user_profile.dart';
import 'package:mentis_ai/screens/widgets/bottom_navbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  int _steps = 0;
  double _calories = 0.0;
  int _heartRate = 0;
  int _sleepMinutes = 0;

  // void _updateHealthData(int steps, double calories) {
  //   setState(() {
  //     _steps = steps;
  //     _calories = calories;
  //   });
  // }

  void _updateHealthData(
      {required int steps,
      required double calories,
      required int heartRate,
      required int sleepMinutes}) {
    if (!mounted) return;
    setState(() {
      _steps = steps;
      _calories = calories;
      _heartRate = heartRate;
      _sleepMinutes = sleepMinutes;
    });
  }

  // static final List<Widget> _screenOptions = <Widget>[
  //   const HomeContent(),
  //   const EvolutionSystem(),
  //   const ScreeeningSystem(),
  //   const UserProfile(),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screenOptions = <Widget>[
      HomeContent(onDataLoaded: _updateHealthData),
      const EvolutionSystem(),
      ScreeeningSystem(
        steps: _steps,
        calories: _calories,
        heartRate: _heartRate, 
        sleepMinutes: _sleepMinutes, 
      ),
      const UserProfile(),
    ];

    return Scaffold(
      body: screenOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
