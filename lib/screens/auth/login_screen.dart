import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../config/app_constants.dart';
import '../../config/app_routes.dart';
import '../../providers/auth_provider.dart';
import '../../utils/validators.dart';
import '../../widgets/common/gradient_text.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animCtrl, curve: const Interval(0.0, 0.6, curve: Curves.easeOut)));
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(CurvedAnimation(parent: _animCtrl, curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic)));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  // LOGIN LOGIC
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = Provider.of<AuthProvider>(context, listen: false);
    final success = await auth.signIn(
      email: _emailCtrl.text.trim(),
      password: _passCtrl.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      if (auth.isAdmin) {
        // ✅ Direct to Admin Dashboard for Admin credentials
        Navigator.pushReplacementNamed(context, AppRoutes.adminDash);
      } else {
        // Professional Flow: Navigate to Interests for normal users
        Navigator.pushReplacementNamed(context, AppRoutes.interests);
      }
    } else {
      _showSnackBar(auth.error ?? 'Login Failed', AppColors.error);
    }
  }

  void _showSnackBar(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color, behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, 
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 60),
                // LOGO
                FadeTransition(
                  opacity: _fadeAnim,
                  child: Container(
                    width: 80, height: 80,
                    decoration: BoxDecoration(shape: BoxShape.circle, gradient: AppColors.buttonGradient),
                    child: const Icon(Icons.auto_awesome, color: Colors.white, size: 40),
                  ),
                ),
                const SizedBox(height: 24),
                GradientText(
                  text: 'Nexora', 
                  gradient: AppColors.textGradient, 
                  style: theme.textTheme.displayLarge?.copyWith(fontSize: 32) ?? GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.bold)
                ),
                const SizedBox(height: 40),

                SlideTransition(
                  position: _slideAnim,
                  child: Column(
                    children: [
                      CustomTextField(
                        hint: 'Email Address',
                        prefixIcon: Icons.email_outlined,
                        controller: _emailCtrl,
                        validator: Validators.email,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        hint: 'Password',
                        prefixIcon: Icons.lock_outline_rounded,
                        isPassword: true,
                        controller: _passCtrl,
                        validator: Validators.password,
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Navigator.pushNamed(context, AppRoutes.forgotPassword),
                          child: Text(
                            'Forgot Password?', 
                            style: GoogleFonts.inter(
                              color: AppColors.royalBlue, 
                              fontWeight: FontWeight.w600
                            )
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                        text: 'LOGIN',
                        isLoading: auth.isLoading,
                        onPressed: _login,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ", 
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary
                            )
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, AppRoutes.signup),
                            child: Text(
                              'Sign Up', 
                              style: GoogleFonts.inter(
                                color: AppColors.royalBlue, 
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
