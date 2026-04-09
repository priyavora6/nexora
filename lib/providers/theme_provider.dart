import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_constants.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false; // Default to light theme (white)

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    // Default to false (light mode) if not set
    _isDarkMode = prefs.getBool(AppConstants.keyThemeMode) ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme(bool isDark) async {
    _isDarkMode = isDark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyThemeMode, isDark);
    notifyListeners();
  }
}
