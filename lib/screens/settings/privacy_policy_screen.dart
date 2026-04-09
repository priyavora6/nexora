// lib/screens/settings/privacy_policy_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';
import '../../widgets/layout/gradient_app_bar.dart';
import '../../widgets/common/nexora_background.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen>
    with SingleTickerProviderStateMixin {
  
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _animatedItem({required Widget child, int delay = 0}) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 800 + delay),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, 40 * (1.0 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const GradientAppBar(title: 'PRIVACY', showBack: true),
      body: NexoraBackground(
        particleCount: 20,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── HEADER ───
              _animatedItem(
                delay: 0,
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.1),
                              blurRadius: 25,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.shield_rounded,
                          color: AppColors.primary,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Privacy Policy',
                        style: GoogleFonts.inter(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: theme.textTheme.displayLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your privacy is important to us',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // ─── POLICY SECTIONS (LIST STYLE) ───
              _animatedItem(
                delay: 100,
                child: _policySection(
                  context,
                  Icons.person_outline_rounded,
                  'Information Collection',
                  'We collect your name and email when you register. Your selected interests and saved prompts are stored to personalize your experience.',
                ),
              ),

              _animatedItem(
                delay: 200,
                child: _policySection(
                  context,
                  Icons.data_usage_rounded,
                  'Data Usage',
                  'Your data helps us maintain your account, save favorites, provide recommendations, and improve the overall app experience.',
                ),
              ),

              _animatedItem(
                delay: 300,
                child: _policySection(
                  context,
                  Icons.lock_outline_rounded,
                  'Security',
                  'Your data is securely stored using Firebase. Passwords are encrypted with industry-standard security measures.',
                ),
              ),

              _animatedItem(
                delay: 400,
                child: _policySection(
                  context,
                  Icons.share_outlined,
                  'Third-Party',
                  'We use Firebase for authentication and storage. We do not sell or share your personal information for marketing.',
                ),
              ),

              _animatedItem(
                delay: 500,
                child: _policySection(
                  context,
                  Icons.manage_accounts_outlined,
                  'Your Rights',
                  'You can access, update, or delete your account data anytime through the app settings.',
                ),
              ),

              _animatedItem(
                delay: 600,
                child: _policySection(
                  context,
                  Icons.update_rounded,
                  'Updates',
                  'We may update this policy periodically. Continued use of Nexora indicates acceptance of any changes.',
                ),
              ),

              const SizedBox(height: 32),

              // ─── FOOTER ───
              _animatedItem(
                delay: 700,
                child: Center(
                  child: Text(
                    'Last updated: January 2025',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _policySection(BuildContext context, IconData icon, String title, String content) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: theme.textTheme.titleLarge?.color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 34), 
            child: Text(
              content,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: theme.textTheme.bodyMedium?.color,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
