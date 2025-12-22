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

  static final List<Widget> _screenOptions = <Widget>[
    const HomeContent(),
    const EvolutionSystem(),
    const ScreeeningSystem(),
    const UserProfile(),
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

