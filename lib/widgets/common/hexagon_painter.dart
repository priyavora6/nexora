import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class HexagonPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final bool showDot;

  HexagonPainter({
    this.color = AppColors.violet, // ✅ Updated default color
    this.strokeWidth = 3.0,
    this.showDot = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final glow = Paint()
      ..color = color.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 2
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final path = Path();
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2;

    for (int i = 0; i < 6; i++) {
      double a = (60 * i + 30) * math.pi / 180;
      double x = c.dx + r * math.cos(a);
      double y = c.dy + r * math.sin(a);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    path.close();

    canvas.drawPath(path, glow);
    canvas.drawPath(path, paint);

    if (showDot) {
      canvas.drawCircle(
        Offset(
          c.dx + r * math.cos(30 * math.pi / 180),
          c.dy + r * math.sin(-30 * math.pi / 180),
        ),
        4,
        Paint()..color = AppColors.royalBlue, // ✅ Updated
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter old) => false;
}