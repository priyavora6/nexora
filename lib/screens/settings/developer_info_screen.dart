import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';
import '../../widgets/layout/gradient_app_bar.dart';
import '../../widgets/common/nexora_background.dart';

class DeveloperInfoScreen extends StatefulWidget {
  const DeveloperInfoScreen({super.key});

  @override
  State<DeveloperInfoScreen> createState() => _DeveloperInfoScreenState();
}

class _DeveloperInfoScreenState extends State<DeveloperInfoScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  Animation<double>? _anim1;
  Animation<double>? _anim2;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _anim1 = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _anim2 = Tween<double>(begin: 80, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const GradientAppBar(title: 'OUR TEAM', showBack: true),
      body: NexoraBackground(
        particleCount: 20,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: Column(
                  children: [
                    // ─── FIRST CARD ───
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (_, child) {
                        return Transform.translate(
                          offset: Offset(0, _anim1!.value),
                          child: Opacity(
                            opacity: (1 - (_anim1!.value / 50)).clamp(0, 1),
                            child: child,
                          ),
                        );
                      },
                      child: const _DeveloperCard(
                        name: 'Priya Vora',
                        role: 'Developer',
                        subtitle: 'Student, B.Tech CE Dept.',
                        initials: 'PV',
                        imagePath: 'assets/priya.jpg',
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ─── SECOND CARD ───
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (_, child) {
                        return Transform.translate(
                          offset: Offset(0, _anim2!.value),
                          child: Opacity(
                            opacity: (1 - (_anim2!.value / 80)).clamp(0, 1),
                            child: child,
                          ),
                        );
                      },
                      child: const _DeveloperCard(
                        name: 'Prof. Jigar Dave',
                        role: 'Project Mentor',
                        subtitle: 'Faculty Guide',
                        initials: 'JD',
                        imagePath: 'assets/mentor.jpg',
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

class _DeveloperCard extends StatefulWidget {
  final String name;
  final String role;
  final String subtitle;
  final String initials;
  final String imagePath;

  const _DeveloperCard({
    required this.name,
    required this.role,
    required this.subtitle,
    required this.initials,
    required this.imagePath,
  });

  @override
  State<_DeveloperCard> createState() => _DeveloperCardState();
}

class _DeveloperCardState extends State<_DeveloperCard> {
  double _scale = 1;

  void _down(_) => setState(() => _scale = 0.96);
  void _up(_) => setState(() => _scale = 1);
  void _cancel() => setState(() => _scale = 1);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size.width * 0.65;

    return GestureDetector(
      onTapDown: _down,
      onTapUp: _up,
      onTapCancel: _cancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        child: Container(
          width: size,
          height: size,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: theme.cardColor.withOpacity(isDark ? 0.9 : 0.85),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.2 : 0.03),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  widget.imagePath,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 80,
                    height: 80,
                    alignment: Alignment.center,
                    color: isDark ? theme.colorScheme.surfaceContainerHighest : theme.colorScheme.surfaceContainerHighest,
                    child: Text(
                      widget.initials,
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.name,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: theme.textTheme.titleLarge?.color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: theme.textTheme.bodyMedium?.color,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget.role.toUpperCase(),
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
