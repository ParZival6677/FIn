import 'package:flutter/material.dart';

class PieChartPainter extends CustomPainter {
  final Map<String, double> data;
  final List<Color> colors;

  PieChartPainter({required this.data, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    double total = data.values.fold(0, (sum, item) => sum + item);
    double startAngle = -3.14 / 2;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 6;

    final radius = size.width / 3;
    final center = Offset(size.width / 2, size.height / 2);

    int colorIndex = 0;

    data.forEach((key, value) {
      final sweepAngle = (value / total) * 3.14 * 2;
      paint.color = colors[colorIndex % colors.length];
      colorIndex++;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += sweepAngle;
    });

    final innerCirclePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.6, innerCirclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PieChart extends StatelessWidget {
  final Map<String, double> data;
  final List<Color> colors;

  PieChart({required this.data, required this.colors});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 200),
      painter: PieChartPainter(data: data, colors: colors),
    );
  }
}
