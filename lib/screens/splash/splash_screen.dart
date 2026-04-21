import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../config/app_colors.dart';
import '../../config/app_constants.dart';
import '../../config/app_routes.dart';
import '../../services/local_storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _pulseController;

  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;
  late Animation<Offset> _slideAnim;
  late Animation<double> _orbPulseAnim;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _mainController,
          curve: const Interval(0.0, 0.6, curve: Curves.easeIn)),
    );

    _scaleAnim = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
          parent: _mainController,
          curve: const Interval(0.0, 0.8, curve: Curves.easeOutBack)),
    );

    _slideAnim =
        Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(
          CurvedAnimation(
              parent: _mainController,
              curve: const Interval(0.2, 0.9, curve: Curves.easeOutCubic)),
        );

    _orbPulseAnim = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _mainController.forward();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 6));
    if (!mounted) return;

    final onboardingSeen = await LocalStorageService.isOnboardingSeen();
    final currentUser = FirebaseAuth.instance.currentUser;

    if (!mounted) return;

    if (!onboardingSeen) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.onboarding);
    } else {
      if (currentUser != null) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      } else {
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      }
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ─── ANIMATED SHADING BACKGROUND ───
          AnimatedBuilder(
            animation: _orbPulseAnim,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    top: -150,
                    left: -100,
                    child: Transform.scale(
                      scale: _orbPulseAnim.value,
                      child: _buildBlurOrb(
                          AppColors.lavender.withOpacity(0.12)), // Lighter opacity
                    ),
                  ),
                  Positioned(
                    bottom: -150,
                    right: -100,
                    child: Transform.scale(
                      scale: _orbPulseAnim.value * 1.1,
                      child: _buildBlurOrb(
                          AppColors.royalBlue.withOpacity(0.12)), // Lighter opacity
                    ),
                  ),
                ],
              );
            },
          ),

          // ─── MAIN CONTENT ───
          Center(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // LOGO IMAGE
                    ScaleTransition(
                      scale: _scaleAnim,
                      child: Container(
                        width: 160, 
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color:
                              AppColors.royalBlue.withOpacity(0.2),
                              blurRadius: 40,
                              offset: const Offset(0, 15),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/icon.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // APP NAME
                    Text(
                      "NEXORA",
                      style: GoogleFonts.poppins(
                        fontSize: 42, 
                        fontWeight: FontWeight.w900,
                        letterSpacing: 6,
                        foreground: Paint()
                          ..shader = AppColors.navGradient
                              .createShader(
                            const Rect.fromLTWH(0, 0, 300, 100),
                          ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // TAGLINE
                    Text(
                      "UNLOCK EXPERT PROMPTS",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2,
                        color: AppColors.textSecondary
                            .withOpacity(0.8),
                      ),
                    ),

                    const SizedBox(height: 60),

                    SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        color: AppColors.violet,
                        backgroundColor:
                        AppColors.lavender.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ─── POWERED BY SECTION ───
          Positioned(
            bottom: 80, // Moved up
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _fadeAnim,
              child: Column(
                children: [
                  Text(
                    "POWERED BY",
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.5,
                      color: AppColors.textSecondary.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Image.asset(
                    'assets/mu-logo.png',
                    height: 55,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurOrb(Color color) {
    return Container(
      width: 400,
      height: 400,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        child: Container(color: Colors.transparent),
      ),
    );
  }
}
