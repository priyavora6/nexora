import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../providers/auth_provider.dart';
import '../../services/firestore_service.dart';
import '../../services/seed_data_service.dart';
import '../../utils/helpers.dart';
import '../../widgets/layout/gradient_app_bar.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  bool _seeding = false;
  String _seedStatus = '';

  Future<void> _seedData() async {
    final confirm = await Helpers.showConfirmDialog(
      context,
      title: 'Seed All Data',
      message:
      'This will add 33 categories and 990 prompts to Firestore. Continue?',
      confirmText: 'Seed Data',
      confirmColor: AppColors.lightCoral,
    );

    if (!confirm) return;

    setState(() {
      _seeding = true;
      _seedStatus = 'Starting...';
    });

    try {
      await SeedDataService().seedAllData(
        onProgress: (status) {
          if (mounted) {
            setState(() => _seedStatus = status);
          }
        },
      );

      // ✅ Success message
      if (mounted) {
        setState(() => _seedStatus = '✅ Data seeded successfully!');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _seedStatus = '❌ Error: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _seeding = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final fs = FirestoreService();

    return Scaffold(
      backgroundColor: Colors.white,

      // ✅ Gradient AppBar with logout
      appBar: GradientAppBar(
        title: 'ADMIN PANEL',
        showBack: false, // ✅ No back button for admin dashboard
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.white),
            tooltip: 'Logout',
            onPressed: () async {
              final confirm = await Helpers.showConfirmDialog(
                context,
                title: 'Logout',
                message: 'Are you sure you want to logout?',
                confirmText: 'Logout',
                confirmColor: AppColors.error,
              );

              if (confirm) {
                await auth.signOut();
                if (!mounted) return;

                // 🔥 CHANGED HERE: Redirect to login and clear all history
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                      (route) => false,
                );
              }
            },
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Stats Section ───
              Row(
                children: [
                  Expanded(
                    child: FutureBuilder<int>(
                      future: fs.getTotalCategories(),
                      builder: (_, s) => _statCard(
                        'Categories',
                        '${s.data ?? 0}',
                        Icons.dashboard_rounded,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FutureBuilder<int>(
                      future: fs.getTotalPrompts(),
                      builder: (_, s) => _statCard(
                        'Prompts',
                        '${s.data ?? 0}',
                        Icons.description_rounded,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // ─── Seed Data Section ───
              Text(
                "Data Management",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 16),

              _actionTile(
                context,
                '🌱 Seed All Data (990 Prompts)',
                Icons.cloud_upload_rounded,
                _seeding ? null : _seedData,
                color: AppColors.success,
              ),

              // ─── Seeding Status Area ───
              if (_seedStatus.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.lightInput,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.border.withOpacity(0.5),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_seeding) ...[
                        const LinearProgressIndicator(
                          color: AppColors.lightCoral,
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(height: 12),
                      ],
                      Text(
                        _seedStatus,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 32),

              // ─── Content Management Section ───
              Text(
                "Content Management",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 16),

              _actionTile(
                context,
                'Manage Categories',
                Icons.category_rounded,
                    () => Navigator.pushNamed(context, AppRoutes.manageCategories),
              ),

              const SizedBox(height: 12),

              _actionTile(
                context,
                'Manage Prompts',
                Icons.edit_note_rounded,
                    () => Navigator.pushNamed(context, AppRoutes.managePrompts),
              ),

              const SizedBox(height: 12),

              _actionTile(
                context,
                'Add New Category',
                Icons.add_circle_rounded,
                    () => Navigator.pushNamed(context, AppRoutes.addEditCategory),
              ),

              const SizedBox(height: 12),

              _actionTile(
                context,
                'Add New Prompt',
                Icons.post_add_rounded,
                    () => Navigator.pushNamed(context, AppRoutes.addEditPrompt),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.lightCoral, size: 32),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionTile(
      BuildContext context,
      String title,
      IconData icon,
      VoidCallback? onTap, {
        Color? color,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: onTap == null ? 0.5 : 1.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border.withOpacity(0.4)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: color ?? AppColors.lightCoral, size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: AppColors.sage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
