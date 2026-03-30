import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';
import '../../widgets/layout/gradient_app_bar.dart';
import '../../widgets/common/nexora_background.dart';

class HowToUseScreen extends StatelessWidget {
  const HowToUseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const GradientAppBar(title: 'HOW TO USE NEXORA', showBack: true),
      body: NexoraBackground(
        particleCount: 15,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(theme),
              const SizedBox(height: 40),
              
              _buildStep(
                theme,
                index: '01',
                title: 'PERSONALIZE YOUR FEED',
                description: 'When you first join, select categories that match your creative style. Nexora uses these to curate a unique feed just for you on the home screen.',
                icon: Icons.tune_rounded,
              ),
              
              _buildStep(
                theme,
                index: '02',
                title: 'DISCOVER PROMPTS',
                description: 'Browse through categories or check your Daily Inspiration. Each prompt is professionally crafted to yield high-quality AI results.',
                icon: Icons.explore_outlined,
              ),
              
              _buildStep(
                theme,
                index: '03',
                title: 'COPY & GENERATE',
                description: 'Found a perfect prompt? Tap the Copy button to save it to your clipboard. Use the "Generate" button to jump directly to the AI platform and start creating.',
                icon: Icons.content_copy_rounded,
              ),
              
              _buildStep(
                theme,
                index: '04',
                title: 'SAVE YOUR FAVORITES',
                description: 'Tap the bookmark icon on any prompt to save it to your library. You can access all your saved prompts anytime from the Bookmarks tab.',
                icon: Icons.bookmark_border_rounded,
              ),
              
              const SizedBox(height: 40),
              _buildProTip(theme),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MASTER THE ART OF\nPROMPT ENGINEERING',
          style: GoogleFonts.inter(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            height: 1.1,
            letterSpacing: -0.5,
            color: theme.textTheme.titleLarge?.color,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Follow these simple steps to get the most out of Nexora and elevate your AI creations.',
          style: GoogleFonts.inter(
            fontSize: 14,
            height: 1.6,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStep(ThemeData theme, {
    required String index,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: AppColors.royalBlue,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.royalBlue.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(icon, color: Colors.white, size: 22),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                index,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: AppColors.royalBlue.withOpacity(0.3),
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                    color: theme.textTheme.titleMedium?.color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    height: 1.6,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProTip(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.navGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.royalBlue.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline_rounded, color: Colors.white, size: 32),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PRO TIP',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Mix and match parts from different prompts to create something entirely new!',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
