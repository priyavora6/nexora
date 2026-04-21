import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBack;

  const CustomAppBar({Key? key, required this.title, this.actions, this.showBack = false}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: showBack ? IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => Navigator.pop(context)) : null,
      actions: actions,
    );
  }
}