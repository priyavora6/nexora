import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';
import '../../widgets/layout/bottom_nav_bar.dart';
import '../../widgets/layout/gradient_app_bar.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const GradientAppBar(title: 'CONTACT US', showBack: true),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Get in Touch', 
              style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            Text('Have questions? Reach out to us through any of these channels.', 
              style: GoogleFonts.raleway(fontSize: 14, color: AppColors.textSecondary, height: 1.5)),
            const SizedBox(height: 32),
            _contactTile(Icons.email_outlined, 'Email', 'support@nexora.com'),
            const SizedBox(height: 16),
            _contactTile(Icons.language_rounded, 'Website', 'www.nexora.com'),
            const SizedBox(height: 16),
            _contactTile(Icons.flutter_dash_rounded, 'Twitter / X', '@NexoraApp'),
          ],
        ),
      ),
    );
  }

  Widget _contactTile(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFCFC), 
        borderRadius: BorderRadius.circular(16), 
        border: Border.all(color: Colors.grey[200]!)
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppColors.lightCoral.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: AppColors.lightCoral, size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, 
                style: GoogleFonts.raleway(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textHint)),
              Text(subtitle, 
                style: GoogleFonts.raleway(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
            ],
          ),
        ],
      ),
    );
  }
}
