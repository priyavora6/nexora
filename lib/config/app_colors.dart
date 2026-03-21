import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ═════════════════════════════════════════════════════════════
  // 🌿 NEXORA CORE PALETTE (Inspired by Logo)
  // ═════════════════════════════════════════════════════════════

  // Primary Brand Colors (Refined to match logo tones)
  static const Color sage         = Color(0xFFAFC5B3); // Refined Soft Sage
  static const Color powderBlush  = Color(0xFFEEC8BE); // Softer Peach
  static const Color lightCoral   = Color(0xFFE57F7A); // Vibrant Coral
  static const Color sweetPeony   = Color(0xFFC86C94); // Elegant Pink
  static const Color smokyRose    = Color(0xFF6E4E55); // Deep Muted Rose

  // ═════════════════════════════════════════════════════════════
  // ⚪ LIGHT THEME
  // ═════════════════════════════════════════════════════════════

  static const Color lightScaffold = Colors.white;
  static const Color lightCard     = Colors.white;
  static const Color lightInput    = Color(0xFFFDF9F8);

  static const Color textPrimary   = Color(0xFF2A2326);
  static const Color textSecondary = Color(0xFF7C5A61);
  static const Color textHint      = Color(0xFFBDAEB2);

  // ═════════════════════════════════════════════════════════════
  // ⚫ DARK THEME (For your dark mode)
  // ═════════════════════════════════════════════════════════════

  static const Color darkScaffold = Color(0xFF121212);
  static const Color darkCard     = Color(0xFF1E1E1E);
  static const Color darkInput    = Color(0xFF2A2A2A);

  static const Color darkTextPrimary   = Colors.white;
  static const Color darkTextSecondary = Color(0xFFBCAFB3);
  static const Color darkTextHint      = Color(0xFF8A7F83);

  // ═════════════════════════════════════════════════════════════
  // 🌈 BRAND GRADIENTS (Aligned with Logo)
  // ═════════════════════════════════════════════════════════════

  // Main Brand Gradient (Navigation + Splash Text)
  static const LinearGradient navGradient = LinearGradient(
    colors: [lightCoral, sweetPeony],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Premium Button Gradient
  static const LinearGradient buttonGradient = LinearGradient(
    colors: [lightCoral, sweetPeony],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Accent Gradient (Logo Inspired - Sage to Coral)
  static const LinearGradient accentGradient = LinearGradient(
    colors: [sage, lightCoral],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Text Gradient
  static const LinearGradient textGradient = LinearGradient(
    colors: [sweetPeony, lightCoral],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ═════════════════════════════════════════════════════════════
  // 🎯 STATUS & ACCENTS
  // ═════════════════════════════════════════════════════════════

  static const Color accent  = lightCoral;
  static const Color success = Color(0xFF7CB97E);
  static const Color error   = Color(0xFFE07070);
  static const Color border  = powderBlush;

  // ═════════════════════════════════════════════════════════════
  // 🏷️ CATEGORY COLORS (Balanced with Logo Palette)
  // ═════════════════════════════════════════════════════════════

  static const List<Color> categoryColors = [
    lightCoral,
    sweetPeony,
    sage,
    powderBlush,
    smokyRose,
    Color(0xFFD8A6A6), // Soft Dusty Rose
    Color(0xFFB8D1C3), // Light Sage Tint
  ];

  static Color getRandomCategoryColor(int index) {
    return categoryColors[index % categoryColors.length];
  }
}