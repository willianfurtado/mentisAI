import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentis_ai/screens/widgets/evolution_system/evolution_cards.dart';

class EvolutionSystem extends StatelessWidget {
  const EvolutionSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            children: [
              //Título
              const Text(
                'Evolução',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 40),

              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20.0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 20.0,
                padding: const EdgeInsets.all(6.0),
                childAspectRatio: 1.2,
                children: [
                  EvolutionCards(
                    title: 'Freq. Cardíaca',
                    iconWidget: SvgPicture.asset(
                      'assets/images/heart-white.svg',
                    ),
                  ),
                  EvolutionCards(
                    title: 'Sono',
                    iconWidget: SvgPicture.asset(
                      'assets/images/moon-white.svg',
                    ),
                  ),
                  EvolutionCards(
                    title: 'Calorias',
                    iconWidget: SvgPicture.asset(
                      'assets/images/fire-white.svg',
                    ),
                  ),
                  EvolutionCards(
                    title: 'Passos',
                    iconWidget: SvgPicture.asset(
                      'assets/images/walk-white.svg',
                      
                    ),
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
