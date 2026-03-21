import 'dart:ui';
import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class ShadedBackground extends StatelessWidget {
  final Widget child;

  const ShadedBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Base White Layer
        Container(color: Colors.white),

        // 2. Top Left Soft Sage Orb
        Positioned(
          top: -150,
          left: -100,
          child: _buildBlurOrb(AppColors.sage.withOpacity(0.25)),
        ),

        // 3. Bottom Right Soft Coral Orb
        Positioned(
          bottom: -150,
          right: -100,
          child: _buildBlurOrb(AppColors.lightCoral.withOpacity(0.25)),
        ),

        // 4. Actual Screen Content
        child,
      ],
    );
  }

  Widget _buildBlurOrb(Color color) {
    return Container(
      width: 400,
      height: 400,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        child: Container(color: Colors.transparent),
      ),
    );
  }
}