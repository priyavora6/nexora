import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class ThemeSwitchButton extends StatelessWidget {
  const ThemeSwitchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tp = Provider.of<ThemeProvider>(context);
    return IconButton(
      icon: Icon(
        tp.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
        color: Theme.of(context).iconTheme.color,
      ),
      onPressed: () => tp.toggleTheme(!tp.isDarkMode),
    );
  }
}