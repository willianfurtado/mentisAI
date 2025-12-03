import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mentis_ai/utils/app-colors.dart';

class SleepBarChart extends StatelessWidget {
  final double progressRatio;

  const SleepBarChart({
    super.key,
    required this.progressRatio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 10.0,
        child: LinearProgressIndicator(
          value: progressRatio,
          backgroundColor: AppColors.gray600.withOpacity(.3),
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0D6A8C)),
          borderRadius: BorderRadius.circular(6.0),
        ));
  }
}
