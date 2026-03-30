import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ═════════════════════════════════════════════════════════════
  // 🌌 NEXORA BLUE & PURPLE PALETTE (Professional & Modern)
  // ═════════════════════════════════════════════════════════════

  // Primary Brand Colors
  static const Color deepNavy     = Color(0xFF1A237E); // Professional Deep Navy
  static const Color royalBlue    = Color(0xFF3949AB); // Rich Royal Blue
  static const Color indigo       = Color(0xFF5C6BC0); // Vibrant Indigo
  static const Color violet       = Color(0xFF7E57C2); // Creative Violet
  static const Color lavender     = Color(0xFF9575CD); // Soft Lavender
  static const Color mistyBlue    = Color(0xFFE8EAF6); // Very Light Blue Background

  // ═════════════════════════════════════════════════════════════
  // ⚪ LIGHT THEME (Clean & Modern)
  // ═════════════════════════════════════════════════════════════

  static const Color lightScaffold = Colors.white;
  static const Color lightCard     = Colors.white;
  static const Color lightInput    = Color(0xFFF5F7FF); // Faint Blue Tint for inputs

  // Text Colors (High Contrast)
  static const Color textPrimary   = Color(0xFF101426); // Near Black Navy
  static const Color textSecondary = Color(0xFF535A7D); // Muted Blue-Grey
  static const Color textHint      = Color(0xFF9BA3C1); // Subtle Hint

  // ═════════════════════════════════════════════════════════════
  // 🌈 PROFESSIONAL GRADIENTS (Blue to Purple)
  // ═════════════════════════════════════════════════════════════

  // Main Brand Gradient (Navigation + Splash Text)
  // This looks very high-end (Indigo to Royal Blue)
  static const LinearGradient navGradient = LinearGradient(
    colors: [royalBlue, violet],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Premium Button Gradient
  static const LinearGradient buttonGradient = LinearGradient(
    colors: [royalBlue, violet],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Accent Gradient (Sky to Indigo)
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF42A5F5), indigo],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Text Gradient (For Titles)
  static const LinearGradient textGradient = LinearGradient(
    colors: [royalBlue, Color(0xFF9C27B0)], // Blue to Deep Magenta/Purple
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ═════════════════════════════════════════════════════════════
  // 🎯 STATUS & ACCENTS
  // ═════════════════════════════════════════════════════════════

  static const Color accent  = royalBlue;
  static const Color success = Color(0xFF4CAF50); // Clean Green
  static const Color error   = Color(0xFFD32F2F); // Alert Red
  static const Color border  = Color(0xFFDDE1F0); // Subtle Blueish Border

  // ═════════════════════════════════════════════════════════════
  // 🏷️ CATEGORY COLORS (Variations of Blue and Purple)
  // ═════════════════════════════════════════════════════════════

  static const List<Color> categoryColors = [
    royalBlue,
    violet,
    Color(0xFF0288D1), // Sky Blue
    indigo,
    Color(0xFFD32F2F), // High Contrast Pink-Red
    Color(0xFF7B1FA2), // Deep Purple
    Color(0xFF0097A7), // Teal Blue
  ];

  static Color getRandomCategoryColor(int index) {
    return categoryColors[index % categoryColors.length];
  }
}