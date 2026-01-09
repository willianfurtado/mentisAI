import 'package:flutter/material.dart';
import 'dart:math';

class RainbowProgressIndicator extends StatelessWidget {
  final List<double> values;
  final List<Color> colors;

  const RainbowProgressIndicator({
    super.key,
    required this.values,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(250, 100),
      painter: ArcProgressPainter(
        values: values,
        colors: colors,
      ),
    );
  }
}

class ArcProgressPainter extends CustomPainter {
  final List<double> values;
  final List<Color> colors;

  ArcProgressPainter({required this.values, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);

    double radius = size.width / 2;

    const double startAngle = pi;
    const double sweepAngle = pi;
    for (int i = 0; i < values.length; i++) {
      final backgroundPaint = Paint()
        ..color = Colors.grey.withOpacity(0.2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12.0
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        backgroundPaint,
      );

      radius -= 19.0;
    }

    radius = size.width / 2;

    for (int i = 0; i < values.length; i++) {
      final progressPaint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12.0
        ..strokeCap = StrokeCap.round;

      final currentSweepAngle = sweepAngle * values[i];

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        currentSweepAngle,
        false,
        progressPaint,
      );

      radius -= 19.0;
    }
  }

  @override
  bool shouldRepaint(covariant ArcProgressPainter oldDelegate) {
    return oldDelegate.values != values || oldDelegate.colors != colors;
  }
}
