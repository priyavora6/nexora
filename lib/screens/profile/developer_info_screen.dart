import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';
import '../../widgets/layout/bottom_nav_bar.dart';
import '../../widgets/layout/gradient_app_bar.dart';

class DeveloperInfoScreen extends StatelessWidget {
  const DeveloperInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const GradientAppBar(title: 'DEVELOPER INFO', showBack: true),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100, 
                width: 100, 
                decoration: BoxDecoration(color: AppColors.lightCoral.withOpacity(0.1), shape: BoxShape.circle), 
                child: const Icon(Icons.code_rounded, size: 50, color: AppColors.lightCoral)
              ),
              const SizedBox(height: 32),
              Text('Developed by Nexora Team', 
                style: GoogleFonts.playfairDisplay(fontSize: 28, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              Text('Flutter Developers & Designers', 
                style: GoogleFonts.raleway(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey[50], 
                  borderRadius: BorderRadius.circular(20), 
                  border: Border.all(color: Colors.grey[200]!)
                ),
                child: Text(
                  'Built with passion using Flutter and Firebase. Aiming to make AI accessible and beautiful for everyone.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(fontSize: 14, color: AppColors.textSecondary, height: 1.6),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _devIcon(Icons.link_rounded),
                  const SizedBox(width: 20),
                  _devIcon(Icons.terminal_rounded),
                  const SizedBox(width: 20),
                  _devIcon(Icons.flutter_dash_rounded),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _devIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.lightCoral.withOpacity(0.1), shape: BoxShape.circle),
      child: Icon(icon, color: AppColors.lightCoral, size: 20),
    );
  }
}
