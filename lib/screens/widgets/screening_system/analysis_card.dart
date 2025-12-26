import 'package:flutter/material.dart';

class AnalysisCard extends StatelessWidget {
  final String text;

  const AnalysisCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 172,
      // width: 60,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 143, 218, 236),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
