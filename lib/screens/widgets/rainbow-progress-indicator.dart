import 'package:flutter/material.dart';
import 'dart:math';

class RainbowProgressIndicator extends StatelessWidget{
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
      size: const Size(200, 100), // Define o tamanho do espaço de desenho
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
    // Ponto central para desenhar o arco (Base central inferior)
    final center = Offset(size.width / 2, size.height); 
    
    // Raio do primeiro arco
    double radius = size.width / 2;

    // Ângulos de início e fim do arco
    // Começa na esquerda (180 graus ou pi radianos) e termina na direita (0 graus)
    const double startAngle = pi;
    const double sweepAngle = pi; // O arco é meia-circunferência (180 graus)

    // 1. Desenhar os Arcos de Fundo (cinza) para mostrar o progresso máximo
    for (int i = 0; i < values.length; i++) {
      final backgroundPaint = Paint()
        ..color = Colors.grey.withOpacity(0.2) // Cor de fundo (cinza claro)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12.0 // Largura do arco
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false, // false: não conecta o arco ao centro
        backgroundPaint,
      );

      // Aumenta o raio para o próximo arco (para que ele fique externo ao anterior)
      radius -= 15.0; 
    }

    // 2. Desenhar os Arcos de Progresso (coloridos)
    // Redefinir o raio inicial
    radius = size.width / 2; 
    
    // Inverter a ordem para desenhar do arco mais externo para o interno (para sobreposição)
    for (int i = 0; i < values.length; i++) {
      final progressPaint = Paint()
        ..color = colors[i] 
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12.0
        ..strokeCap = StrokeCap.round;

      // O ângulo de varredura é o valor de progresso (0.0 a 1.0) multiplicado por PI
      final currentSweepAngle = sweepAngle * values[i]; 

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        currentSweepAngle,
        false,
        progressPaint,
      );
      
      // Aumenta o raio para o próximo arco
      radius -= 15.0; 
    }
  }

  @override
  bool shouldRepaint(covariant ArcProgressPainter oldDelegate) {
    // Repinta se os valores mudarem
    return oldDelegate.values != values || oldDelegate.colors != colors;
  }
}