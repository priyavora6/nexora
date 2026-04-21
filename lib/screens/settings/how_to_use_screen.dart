import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';
import '../../widgets/layout/gradient_app_bar.dart';
import '../../widgets/common/nexora_background.dart';

class HowToUseScreen extends StatefulWidget {
  const HowToUseScreen({Key? key}) : super(key: key);

  @override
  State<HowToUseScreen> createState() => _HowToUseScreenState();
}

class _HowToUseScreenState extends State<HowToUseScreen> with TickerProviderStateMixin {
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const GradientAppBar(title: 'GUIDE', showBack: true),
      body: Stack(
        children: [
          // ─── 🌌 PREMIUM BACKGROUND ORBS ───
          Positioned(
            top: 50,
            right: -100,
            child: _buildBlurOrb(isDark ? AppColors.primary.withOpacity(0.1) : AppColors.royalBlue.withOpacity(0.12), 400),
          ),
          Positioned(
            bottom: -50,
            left: -100,
            child: _buildBlurOrb(isDark ? AppColors.secondary.withOpacity(0.08) : AppColors.violet.withOpacity(0.1), 350),
          ),

          NexoraBackground(
            particleCount: 15,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _animatedEntrance(
                    index: 0,
                    child: _buildHeader(theme),
                  ),
                  const SizedBox(height: 50),
                  
                  _buildStepList(theme),
                  
                  const SizedBox(height: 40),
                  _animatedEntrance(
                    index: 5,
                    child: _buildProTip(),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MASTER THE ART OF\nPROMPTS',
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            height: 1.1,
            letterSpacing: -1,
            color: theme.textTheme.displayLarge?.color ?? const Color(0xFF1A2238),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Elevate your creativity with Nexora.',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8) ?? AppColors.textSecondary.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildStepList(ThemeData theme) {
    final steps = [
      {
        'title': 'PERSONALIZE YOUR FEED',
        'desc': 'Select categories that match your creative style to build a custom inspiration feed.',
        'icon': Icons.tune_rounded,
      },
      {
        'title': 'DISCOVER PROMPTS',
        'desc': 'Browse through professionally crafted prompts designed for high-quality AI results.',
        'icon': Icons.explore_outlined,
      },
      {
        'title': 'COPY & GENERATE',
        'desc': 'Tap Copy to save prompts or use Generate to jump directly to the AI platform.',
        'icon': Icons.content_copy_rounded,
      },
      {
        'title': 'SAVE YOUR FAVORITES',
        'desc': 'Bookmark prompts to build your personal library and access them offline anytime.',
        'icon': Icons.bookmark_border_rounded,
      },
    ];

    return Column(
      children: List.generate(steps.length, (i) {
        return _animatedEntrance(
          index: i + 1,
          child: _FloatingStepItem(
            title: steps[i]['title'] as String,
            description: steps[i]['desc'] as String,
            icon: steps[i]['icon'] as IconData,
            color: i % 2 == 0 ? AppColors.royalBlue : AppColors.violet,
          ),
        );
      }),
    );
  }

  Widget _buildProTip() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: AppColors.navGradient,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: AppColors.royalBlue.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.auto_awesome, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PRO TIP',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Mix and match parts from different prompts to create something unique!',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
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

  Widget _animatedEntrance({required int index, required Widget child}) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (index * 150)),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      curve: Curves.easeOutQuart,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 40 * (1.0 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  Widget _buildBlurOrb(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        child: Container(color: Colors.transparent),
      ),
    );
  }
}

class _FloatingStepItem extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const _FloatingStepItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  State<_FloatingStepItem> createState() => _FloatingStepItemState();
}

class _FloatingStepItemState extends State<_FloatingStepItem> with SingleTickerProviderStateMixin {
  late final AnimationController _floatController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  )..repeat(reverse: true);

  late final Animation<double> _floatAnimation = Tween<double>(
    begin: 0.0,
    end: 12.0,
  ).animate(CurvedAnimation(
    parent: _floatController,
    curve: Curves.easeInOutSine,
  ));

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -_floatAnimation.value),
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 28),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.color.withOpacity(isDark ? 0.2 : 0.15),
                isDark ? theme.cardColor.withOpacity(0.5) : Colors.white.withOpacity(0.05),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(isDark ? 0.15 : 0.08),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                  color: isDark ? theme.cardColor.withOpacity(0.6) : Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.4), width: 1.5),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [widget.color.withOpacity(0.2), widget.color.withOpacity(0.05)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Icon(widget.icon, color: widget.color, size: 26),
                      ),
                    ),
                    const SizedBox(width: 22),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                              color: theme.textTheme.titleMedium?.color ?? (isDark ? Colors.white : const Color(0xFF1A2238)),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.description,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              height: 1.6,
                              fontWeight: FontWeight.w500,
                              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.9) ?? AppColors.textSecondary.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
