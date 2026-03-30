import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // Always light mode now
  bool get isDarkMode => false;

  ThemeProvider();

  Future<void> toggleTheme(bool isDark) async {
    // Do nothing as dark mode is removed
  }
}
