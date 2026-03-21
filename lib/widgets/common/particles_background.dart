import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class ParticlesBackground extends StatefulWidget {
  final int count;
  final Color color;

  const ParticlesBackground({
    Key? key,
    this.count = 30,
    this.color = AppColors.lightCoral, // ✅ Updated default color
  }) : super(key: key);

  @override
  State<ParticlesBackground> createState() => _ParticlesBackgroundState();
}

class _ParticlesBackgroundState extends State<ParticlesBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final List<_P> _particles = [];
  final _rng = math.Random();

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 10))
      ..repeat();
    for (int i = 0; i < widget.count; i++) {
      _particles.add(_P(
        x: _rng.nextDouble(),
        y: _rng.nextDouble(),
        size: _rng.nextDouble() * 3 + 0.5,
        opacity: _rng.nextDouble() * 0.6 + 0.1,
        speed: _rng.nextDouble() * 0.08 + 0.02,
      ));
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => CustomPaint(
        painter: _PPainter(_particles, _ctrl.value, widget.color),
        size: Size.infinite,
      ),
    );
  }
}

class _P {
  final double x, size, opacity, speed;
  double y;
  _P(
      {required this.x,
        required this.y,
        required this.size,
        required this.opacity,
        required this.speed});
}

class _PPainter extends CustomPainter {
  final List<_P> particles;
  final double val;
  final Color color;
  _PPainter(this.particles, this.val, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      double dy = (p.y + val * p.speed) % 1.0;
      canvas.drawCircle(
        Offset(p.x * size.width, dy * size.height),
        p.size,
        Paint()..color = color.withOpacity(p.opacity),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => true;
}