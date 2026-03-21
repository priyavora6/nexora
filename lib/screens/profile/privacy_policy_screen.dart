import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';
import '../../widgets/layout/bottom_nav_bar.dart';
import '../../widgets/layout/gradient_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const GradientAppBar(title: 'PRIVACY POLICY', showBack: true),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Privacy Policy', 
              style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            Text('Last Updated: Today', 
              style: GoogleFonts.raleway(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.lightCoral)),
            const SizedBox(height: 24),
            _policySection('1. Information We Collect', 'We may collect personal information such as your name and email address when you register. We also collect saved prompt preferences to provide a personalized experience.'),
            _policySection('2. How We Use Information', 'Your data is used to maintain your account, save your favorite prompts, and improve app functionality.'),
            _policySection('3. Data Security', 'We implement standard security measures to protect your data. Your passwords are encrypted, and we do not share your personal information with third parties without consent.'),
            _policySection('4. Changes to This Policy', 'We may update this policy periodically. Continued use of the app signifies acceptance of any changes.'),
          ],
        ),
      ),
    );
  }

  Widget _policySection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, 
            style: GoogleFonts.playfairDisplay(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          Text(content, 
            style: GoogleFonts.raleway(fontSize: 14, color: AppColors.textSecondary, height: 1.6)),
        ],
      ),
    );
  }
}
