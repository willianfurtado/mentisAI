import 'package:flutter/material.dart';
import 'package:mentis_ai/screens/widgets/evolution-cards.dart';

class ScreeeningSystem extends StatelessWidget {
  const ScreeeningSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              EvolutionCards(title: 'Freq. Cardiaca', icon: Icons.heart_broken_sharp)
            ],
          ),
        ),
      ),
    );
  }
}
