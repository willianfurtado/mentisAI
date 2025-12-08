import 'package:flutter/material.dart';
import 'package:mentis_ai/utils/app-colors.dart';

class RecomendationCard extends StatelessWidget {
  const RecomendationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 362,
      height: 146,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.gray300,
        borderRadius: BorderRadius.circular(16.0),
        // border: Border.all(color: Colors.grey, width: 1.0),
      ),
      child: const Column(
        children: [
          Text(
            'Recomendações',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 12),
          Center(
            child: Text(
              'Tente fazer uma caminhada de cinco minutos',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.blue900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
