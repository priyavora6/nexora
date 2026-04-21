// lib/screens/home/home_screen.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../models/prompt_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/prompt_provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/cards/prompt_card.dart';
import '../../widgets/layout/bottom_nav_bar.dart';
import '../../widgets/layout/gradient_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  String _getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  String _getTagline() {
    var hour = DateTime.now().hour;
    if (hour < 12) return 'Ready to create something iconic?';
    if (hour < 17) return 'The perfect time for new visions.';
    return 'Reflecting on today\'s best ideas.';
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final promptProv = Provider.of<PromptProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final userInterests = auth.userInterests;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: GradientAppBar(
        title: 'NEXORA',
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              themeProvider.toggleTheme(!themeProvider.isDarkMode);
            },
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── 1. EXECUTIVE HEADER ───
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildOrbitAvatar(context, auth.userName),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${_getGreeting()}, ',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: isDark ? Colors.white : theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  auth.userName,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: isDark ? Colors.white : theme.textTheme.titleLarge?.color,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getTagline(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isDark ? Colors.white : AppColors.primary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // ─── 2. DAILY INSPIRATION (Global Random Prompt) ───
              _sectionHeader(context, 'DAILY INSPIRATION', null),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildDailyPrompt(promptProv),
              ),

              const SizedBox(height: 48),

              // ─── 3. CURATED FOR YOU (Max 10 from Interests) ───
              _sectionHeader(context, 'CURATED FOR YOU', null),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildCuratedPrompts(context, promptProv, userInterests),
              ),

              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  // ─── WIDGET: AVATAR ───
  Widget _buildOrbitAvatar(BuildContext context, String name) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.settings),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.primary.withOpacity(0.15),
            width: 1,
          ),
        ),
        child: Container(
          height: 54,
          width: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.navGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : 'U',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─── WIDGET: DAILY PROMPT (1 Random from Global Pool) ───
  Widget _buildDailyPrompt(PromptProvider prov) {
    return StreamBuilder<List<PromptModel>>(
      stream: prov.promptsStream,
      builder: (context, snap) {
        if (!snap.hasData || snap.data!.isEmpty) {
          return const SizedBox(
            height: 150,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }

        final allPrompts = snap.data!;

        // ✅ Seeded randomness based on date (YYYYMMDD) 
        // This ensures the same random prompt is shown for 24 hours.
        final now = DateTime.now();
        final seed = now.year * 10000 + now.month * 100 + now.day;
        final random = Random(seed);
        final dailyPrompt = allPrompts[random.nextInt(allPrompts.length)];

        return PromptCard(
          prompt: dailyPrompt,
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutes.promptDetail,
            arguments: {'promptId': dailyPrompt.id},
          ),
        );
      },
    );
  }

  // ─── WIDGET: CURATED PROMPTS (Max 10 from Interests) ───
  Widget _buildCuratedPrompts(BuildContext context, PromptProvider prov, List<String> userInterests) {
    return StreamBuilder<List<PromptModel>>(
      stream: prov.getPromptsForInterests(userInterests),
      builder: (context, snap) {
        if (!snap.hasData) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }

        final curatedPrompts = snap.data!;

        if (curatedPrompts.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  Icon(
                    Icons.auto_awesome_outlined,
                    size: 48,
                    color: AppColors.primary.withOpacity(0.4),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No prompts found for your interests',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try updating your interests in settings',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        final displayList = curatedPrompts.length > 10 
            ? curatedPrompts.take(10).toList() 
            : curatedPrompts;

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: displayList.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, i) => PromptCard(
            prompt: displayList[i],
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutes.promptDetail,
              arguments: {'promptId': displayList[i].id},
            ),
          ),
        );
      },
    );
  }

  // ─── WIDGET: SECTION HEADER ───
  Widget _sectionHeader(BuildContext context, String title, String? route) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
            ),
          ),
          if (route != null)
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, route),
              child: Text(
                'SEE ALL',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
