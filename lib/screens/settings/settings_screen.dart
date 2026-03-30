import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../providers/auth_provider.dart';
import '../../providers/prompt_provider.dart';
import '../../widgets/layout/bottom_nav_bar.dart';
import '../../widgets/layout/gradient_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  void _goToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
  }

  // Play Store URL for your app
  static const String _playStoreUrl = 'https://play.google.com/store/apps/details?id=com.priya.nexora';

  Future<void> _launchStore() async {
    final uri = Uri.parse(_playStoreUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final bool isAdmin = auth.isAdmin;
    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        _goToHome(context);
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FE), // Clean light background
        appBar: const GradientAppBar(
          title: 'SETTINGS',
          showBack: true,
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 4),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 24),
                
                // ─── PROFILE HEADER ───
                _buildProfileHeader(context, auth, isAdmin, theme),
                const SizedBox(height: 32),

                // ─── SETTINGS LIST ───
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildSettingTile(
                        context,
                        icon: Icons.info_outline_rounded,
                        title: 'About Nexora',
                        onTap: () => Navigator.pushNamed(context, AppRoutes.aboutApp),
                      ),
                      const SizedBox(height: 12),
                      
                      _buildSettingTile(
                        context,
                        icon: Icons.chat_bubble_outline_rounded,
                        title: 'Feedback',
                        onTap: _launchStore, // Directly launch Play Store
                      ),
                      const SizedBox(height: 12),

                      _buildSettingTile(
                        context,
                        icon: Icons.person_outline_rounded,
                        title: 'Contact Us',
                        onTap: () => Navigator.pushNamed(context, AppRoutes.contactUs),
                      ),
                      const SizedBox(height: 12),

                      _buildSettingTile(
                        context,
                        icon: Icons.shield_outlined,
                        title: 'Privacy Policy',
                        onTap: () => Navigator.pushNamed(context, AppRoutes.privacyPolicy),
                      ),
                      const SizedBox(height: 12),

                      _buildSettingTile(
                        context,
                        icon: Icons.star_border_rounded,
                        title: 'Rate App on Play Store',
                        onTap: _launchStore, // Directly launch Play Store
                      ),
                      const SizedBox(height: 12),

                      _buildSettingTile(
                        context,
                        icon: Icons.code_rounded,
                        title: 'Developers',
                        onTap: () => Navigator.pushNamed(context, AppRoutes.developerInfo),
                      ),
                      const SizedBox(height: 12),

                      _buildSettingTile(
                        context,
                        icon: Icons.help_outline_rounded,
                        title: 'How to Use Nexora',
                        onTap: () => Navigator.pushNamed(context, AppRoutes.howToUse),
                      ),
                      const SizedBox(height: 12),

                      _buildSettingTile(
                        context,
                        icon: Icons.lock_outline_rounded,
                        title: 'Change Password',
                        onTap: () => Navigator.pushNamed(context, AppRoutes.changePassword),
                      ),
                      const SizedBox(height: 12),

                      if (isAdmin) ...[
                        _buildSettingTile(
                          context,
                          icon: Icons.admin_panel_settings_rounded,
                          title: 'Admin Dashboard',
                          iconColor: AppColors.royalBlue,
                          onTap: () => Navigator.pushNamed(context, AppRoutes.adminDash),
                        ),
                        const SizedBox(height: 12),
                      ],

                      _buildSettingTile(
                        context,
                        icon: Icons.verified_outlined,
                        title: 'App Version',
                        trailing: '1.0.0',
                        showArrow: false,
                        onTap: () {},
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // SIGN OUT
                      _buildSettingTile(
                        context,
                        icon: Icons.logout_rounded,
                        title: 'Sign Out',
                        iconColor: AppColors.error,
                        textColor: AppColors.error,
                        showArrow: false,
                        onTap: () async {
                          await auth.signOut();
                          if (context.mounted) {
                            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, AuthProvider auth, bool isAdmin, ThemeData theme) {
    return Column(
      children: [
        Container(
          height: 90, width: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle, 
            gradient: AppColors.navGradient, 
            boxShadow: [
              BoxShadow(
                color: AppColors.royalBlue.withOpacity(0.2), 
                blurRadius: 15, 
                offset: const Offset(0, 5)
              )
            ]
          ),
          child: Center(
            child: Text(
              isAdmin ? 'A' : (auth.userName.isNotEmpty ? auth.userName[0].toUpperCase() : 'U'), 
              style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          (isAdmin ? 'Administrator' : auth.userName), 
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
        ),
        Text(
          auth.userEmail, 
          style: theme.textTheme.bodySmall?.copyWith(color: AppColors.textSecondary)
        ),
      ],
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    String? trailing,
    Color? textColor,
    Color? iconColor,
    bool showArrow = true,
  }) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (iconColor ?? const Color(0xFF6C63FF)).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor ?? const Color(0xFF6C63FF), size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: textColor ?? Colors.black87,
                ),
              ),
            ),
            if (trailing != null)
              Text(
                trailing,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w500,
                ),
              )
            else if (showArrow)
              Icon(Icons.chevron_right_rounded, color: Colors.grey[300], size: 20),
          ],
        ),
      ),
    );
  }
}
