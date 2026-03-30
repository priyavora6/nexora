import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class CornerFrame extends StatelessWidget {
  final Color? color;
  const CornerFrame({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _Painter(
        color: color ?? AppColors.royalBlue, // ✅ Updated default color
      ),
      size: Size.infinite,
    );
  }
}

class _Painter extends CustomPainter {
  final Color color;
  _Painter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    const l = 50.0, o = 20.0;

    canvas.drawLine(Offset(o, o), Offset(o + l, o), p);
    canvas.drawLine(Offset(o, o), Offset(o, o + l), p);

    canvas.drawLine(
        Offset(size.width - o, o), Offset(size.width - o - l, o), p);
    canvas.drawLine(
        Offset(size.width - o, o), Offset(size.width - o, o + l), p);

    canvas.drawLine(
        Offset(o, size.height - o), Offset(o + l, size.height - o), p);
    canvas.drawLine(
        Offset(o, size.height - o), Offset(o, size.height - o - l), p);

    canvas.drawLine(Offset(size.width - o, size.height - o),
        Offset(size.width - o - l, size.height - o), p);
    canvas.drawLine(Offset(size.width - o, size.height - o),
        Offset(size.width - o, size.height - o - l), p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}