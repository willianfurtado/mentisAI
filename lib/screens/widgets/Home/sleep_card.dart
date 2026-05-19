import 'package:flutter/material.dart';
import 'package:mentis_ai/screens/widgets/Home/sleep_bar_chart.dart';
import 'package:mentis_ai/utils/app-colors.dart';

class SleepCard extends StatelessWidget {
  final String title;
  final String duration;
  final double sleepProgress;
  final Widget iconWidget;

  const SleepCard({
    super.key,
    required this.title,
    required this.duration,
    required this.sleepProgress,
    required this.iconWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 69,
      width: 375,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.grey, width: 1.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Sono',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  iconWidget,
                ],
              ),

              //Duração
              Text(
                duration,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          SleepBarChart(progressRatio: sleepProgress),
        ],
      ),
    );
  }
}
