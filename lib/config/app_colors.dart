import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ═════════════════════════════════════════════════════════════
  // 🌌 NEXORA BRAND COLORS (Professional & Modern)
  // ═════════════════════════════════════════════════════════════

  // Primary Brand Colors (From dark theme spec)
  static const Color primary      = Color(0xFF6366F6); // Royal Blue
  static const Color secondary    = Color(0xFF06B6D4); // Cyan/Secondary
  
  // Legacy aliases to fix build errors (mapped to new palette)
  static const Color royalBlue    = primary; 
  static const Color violet       = Color(0xFF8B5CF6);
  static const Color indigo       = Color(0xFF5C6BC0);
  static const Color lavender     = Color(0xFF9575CD);
  
  // 🌙 Dark Theme Palette
  static const Color darkScaffold = Color(0xFF0F0F23); // Deep Space Blue
  static const Color darkCard     = Color(0xFF1A1B2E); // Dark Surface
  static const Color darkInput    = Color(0xFF25273D); // Dark Input BG
  static const Color darkBorder   = Color(0xFF404462); // Dark Outline

  // ☀️ Light Theme Palette
  static const Color lightScaffold = Color(0xFFF8FAFC); // Slate-50
  static const Color lightCard     = Colors.white;      // White
  static const Color lightInput    = Color(0xFFF1F5F9); // Slate-100
  static const Color lightBorder   = Color(0xFFE2E8F0); // Slate-200

  // Legacy alias for border
  static const Color border        = lightBorder;

  // Text Colors (High Contrast)
  static const Color textPrimaryLight   = Color(0xFF1E293B); // Slate-800
  static const Color textSecondaryLight = Color(0xFF64748B); // Slate-500
  
  // Legacy aliases for text
  static const Color textPrimary        = textPrimaryLight;
  static const Color textSecondary      = textSecondaryLight;
  static const Color textHint           = Color(0xFF94A3B8); // Slate-400
  
  static const Color textPrimaryDark    = Color(0xFFE5E7EB); // Light Grey
  static const Color textSecondaryDark  = Color(0xFFB8BDC4); // Muted Grey

  // ═════════════════════════════════════════════════════════════
  // 🌈 PROFESSIONAL GRADIENTS
  // ═════════════════════════════════════════════════════════════

  // Main Brand Gradient (Navigation + Top Bars)
  static const LinearGradient navGradient = LinearGradient(
    colors: [primary, Color(0xFF8B5CF6)], // Royal Blue to Violet
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Legacy aliases for gradients
  static const LinearGradient buttonGradient = primaryGradient;
  static const LinearGradient textGradient   = navGradient;

  // ═════════════════════════════════════════════════════════════
  // 🎯 STATUS & ACCENTS
  // ═════════════════════════════════════════════════════════════

  static const Color success = Color(0xFF10B981); // Emerald Green
  static const Color error   = Color(0xFFEF4444); // Rose Red
  static const Color warning = Color(0xFFF59E0B); // Amber

  // ═════════════════════════════════════════════════════════════
  // 🏷️ CATEGORY COLORS
  // ═════════════════════════════════════════════════════════════

  static const List<Color> categoryColors = [
    primary,
    secondary,
    Color(0xFF8B5CF6), // Violet
    Color(0xFFEC4899), // Pink
    Color(0xFFF59E0B), // Amber
    Color(0xFF10B981), // Emerald
    Color(0xFF3B82F6), // Blue
  ];

  static Color getRandomCategoryColor(int index) {
    return categoryColors[index % categoryColors.length];
  }
}
