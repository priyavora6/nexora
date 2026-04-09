import 'dart:math';
import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class NexoraBackground extends StatefulWidget {
  final Widget child;
  final int particleCount;

  const NexoraBackground({
    Key? key,
    required this.child,
    this.particleCount = 15,
  }) : super(key: key);

  @override
  State<NexoraBackground> createState() => _NexoraBackgroundState();
}

class _NexoraBackgroundState extends State<NexoraBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 25),
  );
  
  late final List<_FloatingOrb> _orbs = List.generate(
    widget.particleCount,
    (_) => _FloatingOrb.random(),
  );

  @override
  void initState() {
    super.initState();
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _OrbPainter(_orbs, _controller.value),
          child: widget.child,
        );
      },
    );
  }
}

class _FloatingOrb {
  final Offset basePosition;
  final double size;
  final double speed;
  final double opacity;
  final double phase;
  final double drift;
  final Color color1;
  final Color color2;

  _FloatingOrb({
    required this.basePosition,
    required this.size,
    required this.speed,
    required this.opacity,
    required this.phase,
    required this.drift,
    required this.color1,
    required this.color2,
  });

  factory _FloatingOrb.random() {
    final rand = Random();
    final colors = [
      AppColors.royalBlue,
      AppColors.violet,
      AppColors.indigo,
      AppColors.lavender,
    ];

    return _FloatingOrb(
      basePosition: Offset(rand.nextDouble(), rand.nextDouble()),
      size: rand.nextDouble() * 140 + 100,
      speed: rand.nextDouble() * 0.12 + 0.04,
      opacity: rand.nextDouble() * 0.1 + 0.05,
      phase: rand.nextDouble() * pi * 2,
      drift: rand.nextDouble() * 0.12 + 0.08,
      color1: colors[rand.nextInt(colors.length)],
      color2: colors[rand.nextInt(colors.length)],
    );
  }
}

class _OrbPainter extends CustomPainter {
  final List<_FloatingOrb> orbs;
  final double animationValue;

  _OrbPainter(this.orbs, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    for (final orb in orbs) {
      final xDrift = sin(animationValue * pi * 2 * orb.speed + orb.phase) * orb.drift;
      final yDrift = cos(animationValue * pi * 2 * orb.speed + orb.phase) * orb.drift;

      final center = Offset(
        (orb.basePosition.dx + xDrift) * size.width,
        (orb.basePosition.dy + yDrift) * size.height,
      );

      final paint = Paint()
        ..shader = RadialGradient(
          colors: [
            orb.color1.withOpacity(orb.opacity),
            orb.color2.withOpacity(orb.opacity * 0.4),
            orb.color1.withOpacity(0.0),
          ],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: orb.size));

      canvas.drawCircle(center, orb.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _OrbPainter oldDelegate) => true;
}
