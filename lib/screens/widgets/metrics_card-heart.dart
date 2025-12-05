import 'package:flutter/material.dart';
import 'package:mentis_ai/screens/widgets/heart-rate-bar-char.dart';

class MetricsCardHeart extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final Widget icon;
  final List<double> chartData;

  const MetricsCardHeart({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.chartData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 232,
      width: 170,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.grey, width: 1.0),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Freq Cardíaca',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              icon,
            ],
          ),

          const SizedBox(height: 10),
          
          HeartRateBarChart(heartRateData: chartData),

          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          Text(
            unit,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
