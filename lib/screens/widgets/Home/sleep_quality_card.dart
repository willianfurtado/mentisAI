import 'package:flutter/material.dart';
import 'package:mentis_ai/screens/widgets/home/sleep_quality_bar_chart.dart';
import 'package:mentis_ai/utils/app-colors.dart';

class SleepQualityCard extends StatelessWidget {
  final String title;
  final List<double> qualityOfSleepData;

  const SleepQualityCard({
    super.key,
    required this.title,
    required this.qualityOfSleepData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.grey, width: 1.0),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          SleepQualityBarChart(qualityData: qualityOfSleepData),
        ],
      ),
    );
  }
}
