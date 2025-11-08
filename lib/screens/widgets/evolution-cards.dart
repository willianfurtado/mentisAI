import 'package:flutter/material.dart';

class EvolutionCards extends StatelessWidget {
  const EvolutionCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 101,
      width: 170,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
    );
  }
}