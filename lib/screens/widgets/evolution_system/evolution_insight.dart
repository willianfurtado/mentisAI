import 'package:flutter/material.dart';
import 'package:mentis_ai/utils/app-colors.dart';

class EvolutionInsight extends StatelessWidget {
  const EvolutionInsight({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 362,
      height: 190,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.gray500, width: 1.0),
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'MentisAI Insight',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Na última semana, sua média de passos diária caiu. Uma caminhada ajuda  a melhorar a saúde mental, além de manter o peso corporal e diminuir o risco de obesidade',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppColors.gray700,
            ),
          ),
        ],
      ),
    );
  }
}
