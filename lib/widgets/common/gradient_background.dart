import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBack;

  const GradientAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.showBack = false,
  }) : super(key: key);

  // Added a bit of extra height for a more premium, spacious feel
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 4);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // ✅ Uses the unified Sage & Rose gradient
        gradient: AppColors.navGradient,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(
        title: Text(
          title.toUpperCase(), // Uppercase for a cleaner, professional look
          style: GoogleFonts.playfairDisplay(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        // ✅ Back button styling
        leading: showBack
            ? IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 20),
          onPressed: () => Navigator.pop(context),
        )
            : null,
        // ✅ Actions (Icons on the right)
        actions: actions,
        backgroundColor: Colors.transparent, // Required to show container gradient
        elevation: 0, // Shadow handled by the parent Container
      ),
    );
  }
}