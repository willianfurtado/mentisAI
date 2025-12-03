import 'package:flutter/material.dart';
import 'package:mentis_ai/utils/app-colors.dart';
import 'dart:math';

class GaugeChart extends StatelessWidget {
  const GaugeChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      child: CustomPaint(
        painter: GaugePainter(
          score: 75.0,
          riskGroup: 'Alto risco',
          filledColor: AppColors.supportOrange,
          emptyColor: AppColors.gray600,
        ),
      ),
    );
  }
}

class GaugePainter extends CustomPainter {
  final double score;
  final String riskGroup;
  final Color filledColor;
  final Color emptyColor;

  const GaugePainter({
    required this.score,
    required this.riskGroup,
    required this.filledColor,
    required this.emptyColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    const radius = 100.0;
    const strokeWidth = 20.0;

    final sweepAngle = (score / 100) * pi; 
    const startAngle = pi;
    
    //Desenha o Arco Cinza (Parte Vazia)
    final emptyPaint = Paint()
      ..color = emptyColor // Cinza claro
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Desenha o arco completo, de 180° a 0°
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      -pi, // -pi desenha de 180 a 0
      false,
      emptyPaint,
    );

    //  Arco Laranja (Progresso) 
    final filledPaint = Paint()
      ..color = filledColor // Laranja
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final textPainter = TextPainter(
      text: TextSpan(
        text: riskGroup,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: size.width);
    
    // Posição para o texto ('Grupo de alto risco')
    final textOffset = Offset(
      center.dx - textPainter.width / 2,
      center.dy - textPainter.height - 25, // Ajusta a posição
    );
    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(covariant GaugePainter oldDelegate) {
    // Redesenha apenas se o score ou o grupo de risco mudar
    return oldDelegate.score != score || oldDelegate.riskGroup != riskGroup;
  }
}