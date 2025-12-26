import 'package:flutter/material.dart';
import 'package:health/health.dart';
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

  final Health health = Health();

  static final List<Widget> _screenOptions = <Widget>[
    const HomeContent(),
    const EvolutionSystem(),
    const ScreeeningSystem(),
    const UserProfile(),
  ];

  @override
  void initState() {
    super.initState();
    verificarHealthConnect();
  }

  Future<void> verificarHealthConnect() async {
    await health.configure();

    HealthConnectSdkStatus? status = await health.getHealthConnectSdkStatus();

    if (status == HealthConnectSdkStatus.sdkUnavailable ||
        status == HealthConnectSdkStatus.sdkUnavailableProviderUpdateRequired) {
      await health.installHealthConnect();
    } else {
      print("Helth Connect está configurado!");
      await solicitarPermissoes();
    }
  }

  Future<void> solicitarPermissoes() async {
    var types = [
      HealthDataType.HEART_RATE,
      HealthDataType.STEPS,
      HealthDataType.SLEEP_SESSION,
      HealthDataType.WORKOUT,
      HealthDataType.BLOOD_OXYGEN,
      HealthDataType.ACTIVE_ENERGY_BURNED
    ];

    bool requested = await health.requestAuthorization(types);

    if (requested) {
      print("Permissões soliticadas!");
    } else {
      print("Permissões negadas pelo usuário ou falha na solicitação.");
    }
  }

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
