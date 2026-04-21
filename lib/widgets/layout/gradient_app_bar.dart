import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBack;
  final VoidCallback? onBackPressed;

  const GradientAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.showBack = false,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 6);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.navGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.royalBlue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: AppBar(
        // --- PROPER HEADER FIX: Text will never cut ---
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: Text(
              title, // Using Title Case for "Proper" look and space saving
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ),
        centerTitle: true,
        leading: showBack
            ? IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: onBackPressed ?? () => Navigator.pop(context),
        )
            : null,
        actions: actions,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}