import 'package:flutter/material.dart';

class NexoraBackground extends StatelessWidget {
  final Widget child;
  final int particleCount;

  const NexoraBackground({
    Key? key,
    required this.child,
    this.particleCount = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 🚫 Bubbles removed from everywhere using this widget
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }
}
