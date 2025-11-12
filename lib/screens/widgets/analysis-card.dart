import 'package:flutter/material.dart';

class AnalysisCard extends StatelessWidget {
  final String text;

  const AnalysisCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 172,
      // width: 60,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[400],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
      ),
    );
  }
}
