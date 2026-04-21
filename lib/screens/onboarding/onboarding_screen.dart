import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/app_colors.dart';
import '../../config/app_constants.dart';
import '../../config/app_routes.dart';
import '../../services/local_storage_service.dart';
import '../../widgets/common/hexagon_painter.dart';
import '../../widgets/common/gradient_text.dart';
import '../../widgets/common/custom_button.dart';

/// The [OnboardingScreen] is shown to users on their first launch of the app.
/// It uses a PageView to showcase the app's primary value propositions.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  
  // ─── STATE CONTROLLERS ─────────────────────────────────────────────────────
  final PageController _pc = PageController();
  int _current = 0; // Keeps track of the current page index

  // ─── ANIMATION CONTROLLERS ─────────────────────────────────────────────────
  late AnimationController _floatCtrl;
  late AnimationController _pulseCtrl;
  late Animation<double> _float;
  late Animation<double> _pulse;

  // ─── ICONS CONFIGURATION ──────────────────────────────────────────────────
  // These icons correspond to the 3 onboarding pages.
  // Format: [Main Center Icon, Top Right Badge Icon]
  final _icons = [
    [Icons.auto_awesome_rounded, Icons.search_rounded], // Page 1
    [Icons.dashboard_rounded, Icons.category_rounded], // Page 2
    [Icons.content_copy_rounded, Icons.bolt_rounded],   // Page 3
  ];

  @override
  void initState() {
    super.initState();
    
    // Floating animation (up and down motion)
    _floatCtrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 3))
      ..repeat(reverse: true);
    _float = Tween(begin: -10.0, end: 10.0).animate(
        CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut));

    // Pulsing animation (scaling effect)
    _pulseCtrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _pulse = Tween(begin: 0.85, end: 1.0).animate(
        CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pc.dispose();
    _floatCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  // ─── NAVIGATION LOGIC ──────────────────────────────────────────────────────

  /// Marks onboarding as complete in local storage and navigates to Login
  Future<void> _complete() async {
    await LocalStorageService.setOnboardingSeen();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(AppRoutes.login);
  }

  /// Handles the "Next" button logic: either go to next page or finish
  void _next() {
    if (_current < AppConstants.onboardingPages.length - 1) {
      _pc.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic);
    } else {
      _complete();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Data for titles and subtitles is pulled from AppConstants
    final pages = AppConstants.onboardingPages;

    return Scaffold(
      backgroundColor: AppColors.lightScaffold,
      body: SafeArea(
        child: Column(
          children: [
            
            // ─── TOP BAR (Progress & Skip) ───────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page Counter (e.g., "1 / 3")
                  Text(
                    '${_current + 1} / ${pages.length}',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  
                  // Skip button - shown on all pages except the last one
                  if (_current < pages.length - 1)
                    GestureDetector(
                      onTap: _complete,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.lightInput,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Text(
                          'SKIP',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                            color: AppColors.royalBlue,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // ─── MAIN PAGE CONTENT ───────────────────────────────────────────
            Expanded(
              child: PageView.builder(
                controller: _pc,
                itemCount: pages.length,
                onPageChanged: (i) => setState(() => _current = i),
                itemBuilder: (_, i) {
                  final data = pages[i];
                  return AnimatedBuilder(
                    animation: _float,
                    builder: (_, __) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          
                          // ─── HERO ILLUSTRATION (Icons & Shapes) ────────────
                          Transform.translate(
                            offset: Offset(0, _float.value),
                            child: ScaleTransition(
                              scale: _pulse,
                              child: SizedBox(
                                width: 200,
                                height: 200,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Background Circle Glow (Soft Blue tint)
                                    Container(
                                      width: 180,
                                      height: 180,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.royalBlue.withOpacity(0.08),
                                      ),
                                    ),
                                    // Hexagon Decorative Outline
                                    CustomPaint(
                                      size: const Size(150, 150),
                                      painter: HexagonPainter(
                                        color: AppColors.indigo.withOpacity(0.4),
                                        strokeWidth: 2.5,
                                      ),
                                    ),
                                    // Main Center Icon with Gradient and Shadow
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: AppColors.buttonGradient,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.royalBlue.withOpacity(0.3),
                                            blurRadius: 25,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        _icons[i][0],
                                        size: 38,
                                        color: Colors.white,
                                      ),
                                    ),
                                    // Floating Small Badge (Top-Right)
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            border: Border.all(
                                              color: AppColors.violet.withOpacity(0.4),
                                              width: 1.5,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.05),
                                                blurRadius: 5,
                                              )
                                            ]
                                        ),
                                        child: Icon(
                                          _icons[i][1],
                                          size: 16,
                                          color: AppColors.violet,
                                        ),
                                      ),
                                    ),
                                    // Decorative Accent Dot
                                    Positioned(
                                      bottom: 15,
                                      left: 15,
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.lavender,
                                        ),
                                      ),
                                    ),
                                    // Emoji Badge (Top-Left)
                                    Positioned(
                                      top: 5,
                                      left: 25,
                                      child: Text(
                                        data['emoji']!,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 60),
                          
                          // ─── TITLE & DESCRIPTION ───────────────────────────
                          
                          // Gradient Headline
                          GradientText(
                            text: data['title']!.toUpperCase(),
                            style: GoogleFonts.inter(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                            gradient: AppColors.textGradient,
                          ),
                          const SizedBox(height: 20),
                          
                          // Descriptive Subtitle Text
                          Text(
                            data['subtitle']!,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              height: 1.6,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(flex: 2),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // ─── FOOTER (Dots & Action Button) ───────────────────────────────
            
            // Pagination Progress Indicators (Dots)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(pages.length, (i) {
                bool active = i == _current;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: active ? 32 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: active ? AppColors.royalBlue : AppColors.border,
                    boxShadow: active
                        ? [
                      BoxShadow(
                        color: AppColors.royalBlue.withOpacity(0.2),
                        blurRadius: 8,
                      ),
                    ]
                        : [],
                  ),
                );
              }),
            ),

            const SizedBox(height: 30),

            // Main CTA Button (Next / Get Started)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: CustomButton(
                text: _current == pages.length - 1 ? 'GET STARTED' : 'NEXT',
                icon: _current == pages.length - 1
                    ? Icons.rocket_launch_rounded
                    : Icons.arrow_forward_rounded,
                onPressed: _next,
                width: _current == pages.length - 1 ? 220 : 180,
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}