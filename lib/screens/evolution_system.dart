import 'package:flutter/material.dart';
import 'package:mentis_ai/screens/widgets/evolution-cards.dart';

class EvolutionSystem extends StatelessWidget {
  const EvolutionSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            children: [
              //Título 
              Center(
                child: Text(
                  'Evolução',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),

              EvolutionCards(title: 'Freq. Cardíaca', icon: Icons.heart_broken),
            ],
          ),
        ),
      ),
    );
  }
}
