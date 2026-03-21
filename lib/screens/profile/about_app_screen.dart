import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';
import '../../widgets/layout/bottom_nav_bar.dart';
import '../../widgets/layout/gradient_app_bar.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const GradientAppBar(title: 'ABOUT NEXORA', showBack: true),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 100, width: 100, decoration: BoxDecoration(gradient: AppColors.navGradient, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: AppColors.lightCoral.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))]), child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 50)),
                const SizedBox(height: 32),
                Text('Nexora', style: GoogleFonts.playfairDisplay(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                const SizedBox(height: 8),
                Text('The Ultimate AI Prompt Library', style: GoogleFonts.raleway(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.lightCoral)),
                const SizedBox(height: 32),
                Text('Discover, save, and copy the best prompts for Midjourney, ChatGPT, and more.', textAlign: TextAlign.center, style: GoogleFonts.raleway(fontSize: 15, color: AppColors.textSecondary, height: 1.6)),
                const SizedBox(height: 48),
                Text('Version 1.0.0', style: GoogleFonts.raleway(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textHint)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}