import 'package:flutter/material.dart';
import 'package:mentis_ai/screens/widgets/sleep-bar-chart.dart';
import 'package:mentis_ai/utils/app-colors.dart';

class SleepCard extends StatelessWidget {
  final String title;

  const SleepCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 69,
      width: 375,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.grey, width: 1.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Linha do título
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Lado esquerdo
              Row(
                children: [
                  Text(
                    'Sono',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.bed, color: AppColors.blue800, size: 24),
                ],
              ),

              //Duração
              Text(
                '6H',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          //Barra de progresso
          SleepBarChart(progressRatio: 0.6),
        ],
      ),
    );
  }
}
