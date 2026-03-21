import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../providers/auth_provider.dart';
import '../../providers/prompt_provider.dart';
import '../../widgets/layout/bottom_nav_bar.dart';
import '../../widgets/layout/gradient_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  void _goToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final bool isAdmin = auth.isAdmin;

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        _goToHome(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: GradientAppBar(
          title: 'PROFILE',
          showBack: true,
          onBackPressed: () => _goToHome(context),
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 4),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 24),
                _buildProfileHeader(auth, isAdmin),
                const SizedBox(height: 40),

                // ─── 2. ACCOUNT SECTION ───
                _buildSectionTitle('ACCOUNT'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      if (isAdmin) ...[
                        _buildMenuItem(
                          icon: Icons.admin_panel_settings_rounded, title: 'Admin Dashboard',
                          textColor: Colors.blueAccent, iconColor: Colors.blueAccent,
                          onTap: () => Navigator.pushNamed(context, AppRoutes.adminDash),
                        ),
                        const SizedBox(height: 12),
                      ],
                      _buildMenuItem(
                        icon: Icons.bookmark_remove_rounded, title: 'Clear Saved Prompts',
                        onTap: () => _showClearFavoritesDialog(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // ─── 3. SUPPORT & FEEDBACK ───
                _buildSectionTitle('SUPPORT & FEEDBACK'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      _buildMenuItem(
                        icon: Icons.chat_bubble_outline_rounded, title: 'Send Feedback',
                        onTap: () => Navigator.pushNamed(context, AppRoutes.feedback),
                      ),
                      const SizedBox(height: 12),
                      _buildMenuItem(
                        icon: Icons.mail_outline_rounded, title: 'Contact Us',
                        onTap: () => Navigator.pushNamed(context, AppRoutes.contactUs),
                      ),
                      const SizedBox(height: 12),
                      _buildMenuItem(
                        icon: Icons.star_outline_rounded, title: 'Rate Us', iconColor: Colors.orange,
                        onTap: () => _showRateUsDialog(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // ─── 4. LEGAL & ABOUT ───
                _buildSectionTitle('ABOUT NEXORA'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      _buildMenuItem(
                        icon: Icons.info_outline_rounded, title: 'About the App',
                        onTap: () => Navigator.pushNamed(context, AppRoutes.aboutApp),
                      ),
                      const SizedBox(height: 12),
                      _buildMenuItem(
                        icon: Icons.shield_outlined, title: 'Privacy Policy',
                        onTap: () => Navigator.pushNamed(context, AppRoutes.privacyPolicy),
                      ),
                      const SizedBox(height: 12),
                      _buildMenuItem(
                        icon: Icons.code_rounded, title: 'Developer Info',
                        onTap: () => Navigator.pushNamed(context, AppRoutes.developerInfo),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // ─── 5. LOGOUT ───
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _buildMenuItem(
                    icon: Icons.logout_rounded, title: 'Sign Out',
                    textColor: AppColors.error, iconColor: AppColors.error, showArrow: false,
                    onTap: () async {
                      await auth.signOut();
                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Text('Nexora v1.0.0', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textHint)),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── HELPER WIDGETS ───
  Widget _buildProfileHeader(AuthProvider auth, bool isAdmin) {
    return Column(
      children: [
        Container(
          height: 110, width: 110,
          decoration: BoxDecoration(shape: BoxShape.circle, gradient: AppColors.navGradient, boxShadow: [BoxShadow(color: AppColors.lightCoral.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 8))]),
          child: Center(
            child: Text(isAdmin ? 'A' : (auth.userName.isNotEmpty ? auth.userName[0].toUpperCase() : 'U'), style: GoogleFonts.poppins(color: Colors.white, fontSize: 44, fontWeight: FontWeight.w700)),
          ),
        ),
        const SizedBox(height: 20),
        Text(isAdmin ? 'Administrator' : auth.userName, style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.textPrimary, letterSpacing: -0.5)),
        const SizedBox(height: 6),
        Text(auth.userEmail, style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(padding: const EdgeInsets.fromLTRB(32, 0, 24, 12), child: Align(alignment: Alignment.centerLeft, child: Text(title, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.textSecondary.withOpacity(0.5), letterSpacing: 1.5))));
  }

  Widget _buildMenuItem({required IconData icon, required String title, required VoidCallback onTap, String? trailing, Color? textColor, Color? iconColor, bool showArrow = true}) {
    final tColor = textColor ?? AppColors.textPrimary;
    final iColor = iconColor ?? AppColors.textSecondary.withOpacity(0.7);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(color: const Color(0xFFFcfcfc), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey[100]!)),
        child: Row(
          children: [
            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: iColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: iColor, size: 20)),
            const SizedBox(width: 16),
            Expanded(child: Text(title, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: tColor))),
            if (trailing != null) Text(trailing, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textHint))
            else if (showArrow) Icon(Icons.arrow_forward_ios_rounded, color: AppColors.textHint.withOpacity(0.5), size: 16),
          ],
        ),
      ),
    );
  }

  void _showClearFavoritesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clear Saved?', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        content: Text('Are you sure you want to remove all saved prompts?', style: GoogleFonts.poppins()),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('CANCEL', style: GoogleFonts.poppins(fontWeight: FontWeight.w600))),
          TextButton(
            onPressed: () {
              Provider.of<PromptProvider>(context, listen: false).clearFavorites();
              Navigator.pop(context);
            },
            child: Text('CLEAR', style: GoogleFonts.poppins(color: Colors.red, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _showRateUsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Rate Us', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        content: Text('Tap a star to rate Nexora on the App Store.', style: GoogleFonts.poppins()),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('LATER', style: GoogleFonts.poppins(fontWeight: FontWeight.w600))),
          TextButton(onPressed: () => Navigator.pop(context), child: Text('RATE NOW', style: GoogleFonts.poppins(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}
