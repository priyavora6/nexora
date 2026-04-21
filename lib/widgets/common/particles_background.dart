import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class ParticlesBackground extends StatefulWidget {
  final int count;
  final List<Color>? colors;

  const ParticlesBackground({
    Key? key,
    this.count = 15,
    this.colors,
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
        vsync: this, duration: const Duration(seconds: 20))
      ..repeat();
    
    final particleColors = widget.colors ?? [
      AppColors.royalBlue.withOpacity(0.3),
      AppColors.violet.withOpacity(0.2),
      AppColors.indigo.withOpacity(0.15),
    ];

    for (int i = 0; i < widget.count; i++) {
      _particles.add(_P(
        x: _rng.nextDouble(),
        y: _rng.nextDouble(),
        // Mixed sizes: Big and Medium
        size: _rng.nextDouble() * 100 + 40, 
        opacity: _rng.nextDouble() * 0.3 + 0.1,
        speed: _rng.nextDouble() * 0.05 + 0.01,
        color: particleColors[_rng.nextInt(particleColors.length)],
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
        painter: _PPainter(_particles, _ctrl.value),
        size: Size.infinite,
      ),
    );
  }
}

class _P {
  final double x, size, opacity, speed;
  final Color color;
  double y;
  _P({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
    required this.speed,
    required this.color,
  });
}

class _PPainter extends CustomPainter {
  final List<_P> particles;
  final double val;
  _PPainter(this.particles, this.val);

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      double dy = (p.y + val * p.speed) % 1.0;
      final center = Offset(p.x * size.width, dy * size.height);
      
      // Drawing with a RadialGradient for a "light gradient way" bubble look
      final paint = Paint()
        ..shader = RadialGradient(
          colors: [
            p.color.withOpacity(p.opacity),
            p.color.withOpacity(0),
          ],
        ).createShader(Rect.fromCircle(center: center, radius: p.size));

      canvas.drawCircle(center, p.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => true;
}
