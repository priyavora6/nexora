// lib/screens/settings/developer_info_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';
import '../../widgets/layout/gradient_app_bar.dart';

class DeveloperInfoScreen extends StatefulWidget {
  const DeveloperInfoScreen({super.key});

  @override
  State<DeveloperInfoScreen> createState() => _DeveloperInfoScreenState();
}

class _DeveloperInfoScreenState extends State<DeveloperInfoScreen>
    with TickerProviderStateMixin {

  late AnimationController _floatController1;
  late AnimationController _floatController2;
  late AnimationController _scaleController;

  late Animation<double> _floatAnimation1;
  late Animation<double> _floatAnimation2;
  late Animation<double> _scaleAnimation1;
  late Animation<double> _scaleAnimation2;

  @override
  void initState() {
    super.initState();
    
    // Floating animation for first card
    _floatController1 = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _floatAnimation1 = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(
        parent: _floatController1,
        curve: Curves.easeInOutSine,
      ),
    );

    // Floating animation for second card
    _floatController2 = AnimationController(
      duration: const Duration(milliseconds: 3500),
      vsync: this,
    );

    _floatAnimation2 = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _floatController2,
        curve: Curves.easeInOutSine,
      ),
    );

    // Scale animation for entrance
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation1 = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _scaleAnimation2 = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutBack),
      ),
    );

    // Start animations
    _scaleController.forward();
    _floatController1.repeat(reverse: true);

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _floatController2.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _floatController1.dispose();
    _floatController2.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.65;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const GradientAppBar(title: 'OUR TEAM', showBack: true),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  const SizedBox(height: 40),

                  // ─── DEVELOPER CARD ───
                  AnimatedBuilder(
                    animation: Listenable.merge([_floatAnimation1, _scaleAnimation1]),
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, -_floatAnimation1.value),
                        child: Transform.scale(
                          scale: _scaleAnimation1.value,
                          child: _DeveloperCard(
                            cardWidth: cardWidth,
                            name: 'Priya Vora',
                            role: 'Developer',
                            subtitle: 'Students,B.Tech CE Dept.',
                            initials: 'PV',
                            imagePath: 'assets/priya.jpg',
                            gradientColors: const [
                              Color(0xFF7E57C2),
                              Color(0xFF9575CD),
                            ],
                            shadowColor: const Color(0xFF7E57C2),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 28),

                  // ─── MENTOR CARD ───
                  AnimatedBuilder(
                    animation: Listenable.merge([_floatAnimation2, _scaleAnimation2]),
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, -_floatAnimation2.value),
                        child: Transform.scale(
                          scale: _scaleAnimation2.value,
                          child: _DeveloperCard(
                            cardWidth: cardWidth,
                            name: 'Prof. Jigar Dave',
                            role: 'Project Mentor',
                            subtitle: 'Faculty Guide',
                            initials: 'JD',
                            imagePath: 'assets/jigar.jpg',
                            gradientColors: const [
                              Color(0xFF3949AB),
                              Color(0xFF5C6BC0),
                            ],
                            shadowColor: const Color(0xFF3949AB),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 48),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// 🎴 DEVELOPER CARD WIDGET
// ═══════════════════════════════════════════════════════════════

class _DeveloperCard extends StatelessWidget {
  final double cardWidth;
  final String name;
  final String role;
  final String subtitle;
  final String initials;
  final String imagePath;
  final List<Color> gradientColors;
  final Color shadowColor;

  const _DeveloperCard({
    required this.cardWidth,
    required this.name,
    required this.role,
    required this.subtitle,
    required this.initials,
    required this.imagePath,
    required this.gradientColors,
    required this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: shadowColor.withOpacity(0.15),
          width: 1,
        ),
        boxShadow: [
          // Main shadow
          BoxShadow(
            color: shadowColor.withOpacity(0.12),
            blurRadius: 40,
            offset: const Offset(0, 20),
            spreadRadius: 0,
          ),
          // Subtle glow
          BoxShadow(
            color: shadowColor.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: -5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ─── PROFILE IMAGE ───
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  gradientColors[0].withOpacity(0.3),
                  gradientColors[1].withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withOpacity(0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback to initials if image not found
                    return Center(
                      child: Text(
                        initials,
                        style: GoogleFonts.inter(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // ─── NAME ───
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 6),

          // ─── SUBTITLE ───
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // ─── ROLE BADGE ───
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  gradientColors[0].withOpacity(0.1),
                  gradientColors[1].withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: gradientColors[0].withOpacity(0.2),
              ),
            ),
            child: Text(
              role.toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
                color: gradientColors[0],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
