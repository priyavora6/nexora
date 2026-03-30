// lib/screens/settings/privacy_policy_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';
import '../../widgets/layout/gradient_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const GradientAppBar(title: 'PRIVACY', showBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── HEADER ───
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.royalBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shield_rounded,
                  color: AppColors.royalBlue,
                  size: 32,
                ),
              ),
            ),

            const SizedBox(height: 24),

            Center(
              child: Text(
                'Privacy Policy',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: theme.textTheme.headlineSmall?.color,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Center(
              child: Text(
                'Your privacy is important to us',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // ─── POLICY SECTIONS ───
            _policySection(
              theme,
              Icons.person_outline_rounded,
              'Information Collection',
              'We collect your name and email when you register. Your selected interests and saved prompts are stored to personalize your experience.',
            ),

            _policySection(
              theme,
              Icons.data_usage_rounded,
              'Data Usage',
              'Your data helps us maintain your account, save favorites, provide recommendations, and improve the overall app experience.',
            ),

            _policySection(
              theme,
              Icons.lock_outline_rounded,
              'Security',
              'Your data is securely stored using Firebase. Passwords are encrypted with industry-standard security measures.',
            ),

            _policySection(
              theme,
              Icons.share_outlined,
              'Third-Party',
              'We use Firebase for authentication and storage. We do not sell or share your personal information for marketing.',
            ),

            _policySection(
              theme,
              Icons.manage_accounts_outlined,
              'Your Rights',
              'You can access, update, or delete your account data anytime through the app settings.',
            ),

            _policySection(
              theme,
              Icons.update_rounded,
              'Updates',
              'We may update this policy periodically. Continued use of Nexora indicates acceptance of any changes.',
            ),

            const SizedBox(height: 32),

            // ─── FOOTER ───
            Center(
              child: Text(
                'Last updated: January 2025',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textHint,
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ─── POLICY SECTION ───
  Widget _policySection(
      ThemeData theme,
      IconData icon,
      String title,
      String content,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.lightInput,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.royalBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.royalBlue,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: theme.textTheme.titleMedium?.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              content,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}