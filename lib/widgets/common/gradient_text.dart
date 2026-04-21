import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;
  final TextAlign textAlign;

  const GradientText({
    Key? key,
    required this.text,
    required this.style,
    this.gradient = AppColors.textGradient,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: Text(text, textAlign: textAlign, style: style.copyWith(color: Colors.white)),
    );
  }
}