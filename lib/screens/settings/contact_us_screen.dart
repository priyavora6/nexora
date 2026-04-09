// lib/screens/settings/contact_us_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/app_colors.dart';
import '../../widgets/layout/gradient_app_bar.dart';
import '../../widgets/common/nexora_background.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFE), // Same as About Us
      appBar: const GradientAppBar(title: 'CONTACT US', showBack: true), // Same Navbar style
      body: NexoraBackground(
        particleCount: 20, // Same as About Us
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── HEADER TEXT ───
              Text(
                'We value your feedback and support. Feel free to reach out to the development team directly.',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: const Color(0xFF535A7D), // Same as About Us secondary text
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),

              // ─── ORGANIZATION CARD ───
              _buildInfoCard(
                iconWidget: Image.asset('assets/mulogo.png', height: 24),
                title: 'Organization',
                value: 'Marwadi University',
                showArrow: false,
              ),

              const SizedBox(height: 16),

              // ─── SUPPORT EMAIL CARD (CLICKABLE) ───
              GestureDetector(
                onTap: () => _sendEmail(context),
                child: _buildInfoCard(
                  iconWidget: const Icon(Icons.mail_outline_rounded, color: AppColors.violet, size: 24),
                  iconBgColor: AppColors.violet.withOpacity(0.08), // Light purple shade
                  title: 'Support Email',
                  value: 'ceapps@marwadieducation.edu.in',
                  showArrow: true,
                  subtitle: 'Tap to send an email instantly',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required Widget iconWidget,
    Color? iconBgColor,
    required String title,
    required String value,
    required bool showArrow,
    String? subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9), // Subtle transparency for background visibility
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: iconBgColor ?? Colors.grey.shade50,
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: iconWidget,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF9BA3C1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: const Color(0xFF1A2238),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (showArrow)
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey.shade300, size: 16),
        ],
      ),
    );
  }

  Future<void> _sendEmail(BuildContext context) async {
    const String email = 'ceapps@marwadieducation.edu.in';
    const String subject = 'Nexora Feedback';
    const String body = 'Hello Team,\n\nI would like to share the following feedback:\n';

    final Uri uri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
    );

    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      await Clipboard.setData(const ClipboardData(text: email));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email address copied to clipboard')),
        );
      }
    }
  }
}
