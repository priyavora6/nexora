import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../providers/auth_provider.dart';
import '../../services/firestore_service.dart';
import '../../services/seed/seed_data_service.dart';
import '../../services/seed/category_data.dart';
import '../../data/prompt_library.dart';
import '../../utils/helpers.dart';
import '../../widgets/layout/gradient_app_bar.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final FirestoreService _fs = FirestoreService();

  bool _seeding = false;
  String _seedStatus = '';
  
  int _libraryCategoryCount = 0;
  int _libraryPromptCount = 0;

  @override
  void initState() {
    super.initState();
    _libraryCategoryCount = CategoryData.getAllCategories().length;
    _libraryPromptCount = PromptLibrary.getAllPrompts().length;
  }

  Future<void> _seedData() async {
    final confirm = await Helpers.showConfirmDialog(
      context,
      title: 'SEED ALL DATA',
      message: 'This will wipe current database and add $_libraryCategoryCount categories. Continue?',
      confirmText: 'SEED DATA',
      confirmColor: AppColors.royalBlue,
    );

    if (!confirm) return;

    setState(() {
      _seeding = true;
      _seedStatus = 'INITIALIZING...';
    });

    try {
      await SeedDataService().seedAllData(
        onProgress: (status) {
          if (mounted) {
            setState(() => _seedStatus = status.toUpperCase());
          }
        },
      );

      if (mounted) {
        setState(() {
          _seedStatus = '✅ DATA SEEDED SUCCESSFULLY!';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _seedStatus = '❌ ERROR: ${e.toString().toUpperCase()}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _seeding = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: GradientAppBar(
        title: 'ADMIN PANEL',
        showBack: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.white),
            onPressed: () async {
              await auth.signOut();
              if (!mounted) return;
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
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
              // ─── LIVE STATS SECTION ───
              Row(
                children: [
                  Expanded(
                    child: StreamBuilder<int>(
                      stream: _fs.getCategoryCount(),
                      builder: (context, snap) {
                        final count = snap.data ?? 0;
                        return _statCard('CATEGORIES', '$count / $_libraryCategoryCount', Icons.dashboard_rounded, theme);
                      }
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: StreamBuilder<int>(
                      stream: _fs.getPromptCount(),
                      builder: (context, snap) {
                        final count = snap.data ?? 0;
                        return _statCard('PROMPTS', '$count / $_libraryPromptCount', Icons.description_rounded, theme);
                      }
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),
              Text("DATA MANAGEMENT", style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900, letterSpacing: 1, color: AppColors.royalBlue)),
              const SizedBox(height: 16),
              _actionTile(
                context,
                title: _seeding ? 'SEEDING...' : '🌱 SEED ALL DATA',
                icon: Icons.cloud_upload_rounded,
                onTap: _seeding ? null : _seedData,
                color: _seeding ? Colors.grey : AppColors.success,
                theme: theme,
              ),
              if (_seedStatus.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.lightInput, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border.withOpacity(0.5))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_seeding) ...[const LinearProgressIndicator(color: AppColors.royalBlue, backgroundColor: Colors.white10), const SizedBox(height: 12)],
                      Text(_seedStatus, style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w800, letterSpacing: 0.5)),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 32),
              Text("CONTENT MANAGEMENT", style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900, letterSpacing: 1, color: AppColors.royalBlue)),
              const SizedBox(height: 16),
              _actionTile(context, title: 'MANAGE CATEGORIES', icon: Icons.category_rounded, onTap: () => Navigator.pushNamed(context, AppRoutes.manageCategories), theme: theme),
              const SizedBox(height: 12),
              _actionTile(context, title: 'MANAGE PROMPTS', icon: Icons.edit_note_rounded, onTap: () => Navigator.pushNamed(context, AppRoutes.managePrompts), theme: theme),
              const SizedBox(height: 12),
              _actionTile(context, title: 'ADD NEW CATEGORY', icon: Icons.add_circle_rounded, onTap: () => Navigator.pushNamed(context, AppRoutes.addEditCategory), theme: theme),
              const SizedBox(height: 12),
              _actionTile(context, title: 'ADD NEW PROMPT', icon: Icons.post_add_rounded, onTap: () => Navigator.pushNamed(context, AppRoutes.addEditPrompt), theme: theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: theme.cardColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: theme.dividerColor.withOpacity(0.1)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))]),
      child: Column(children: [Icon(icon, color: AppColors.royalBlue, size: 32), const SizedBox(height: 12), Text(value, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900), textAlign: TextAlign.center), const SizedBox(height: 4), Text(label, style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w800, fontSize: 10, letterSpacing: 1))]),
    );
  }

  Widget _actionTile(BuildContext context, {required String title, required IconData icon, VoidCallback? onTap, Color? color, required ThemeData theme}) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: onTap == null ? 0.5 : 1.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(color: theme.cardColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey[100]!), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))]),
          child: Row(children: [Icon(icon, color: color ?? AppColors.royalBlue, size: 24), const SizedBox(width: 16), Expanded(child: Text(title, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800, letterSpacing: 0.5, fontSize: 12))), const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.lavender)]),
        ),
      ),
    );
  }
}
