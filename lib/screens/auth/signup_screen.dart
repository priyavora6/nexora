// lib/screens/auth/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../providers/auth_provider.dart';
import '../../utils/validators.dart';
import '../../widgets/common/gradient_text.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_textfield.dart';
import '../../services/emailjs_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _agreedToTerms = false;
  bool _isSendingOTP = false;

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();

    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animCtrl,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animCtrl,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _animCtrl.forward();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  // ─── SHOW ERROR SNACKBAR ───
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // ─── SEND OTP & NAVIGATE TO OTP SCREEN ───
  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_agreedToTerms) {
      _showErrorSnackBar('Please agree to Terms & Conditions');
      return;
    }

    setState(() => _isSendingOTP = true);

    // 1. EmailJS se OTP bhejo
    final result = await EmailJSService.sendOTP(
      userEmail: _emailCtrl.text.trim(),
    );

    setState(() => _isSendingOTP = false);

    if (!mounted) return;

    if (result['success'] == true) {
      // 2. ✅ Agar success hai, toh OTP screen par jao saara data lekar
      Navigator.pushNamed(
        context,
        AppRoutes.otpVerify,
        arguments: {
          'name': _nameCtrl.text.trim(),
          'email': _emailCtrl.text.trim(),
          'password': _passCtrl.text.trim(),
          'otp': result['otp'], // EmailJS wala OTP
          'expiryTime': result['expiryTime'],
        },
      );
    } else {
      // 3. ❌ Agar error aaya, toh error dikhao
      _showErrorSnackBar("Email Error: ${result['error']}");
    }
  }

  // ─── SHOW TERMS & CONDITIONS ───
  void _showTermsAndConditions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Terms & Conditions',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Last Updated: January 2025',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.royalBlue,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Text(
                  '1. Acceptance of Terms\n'
                      'By accessing and using the Nexora application, you accept and agree to be bound by the terms and provisions of this agreement.\n\n'
                      '2. Use of the Application\n'
                      'Nexora provides AI prompt templates for personal and commercial use. You may copy, modify, and use any prompt provided within the application for your own projects.\n\n'
                      '3. User Accounts\n'
                      'When you create an account with us, you must provide accurate and complete information. You are responsible for safeguarding your password and for all activities that occur under your account.\n\n'
                      '4. Content Guidelines\n'
                      'Users must not use Nexora prompts to generate content that is illegal, harmful, threatening, abusive, harassing, defamatory, or otherwise objectionable.\n\n'
                      '5. Intellectual Property\n'
                      'The Nexora application, including its design, features, and content structure, is the intellectual property of the Nexora team. Prompts provided are free to use but the app itself may not be replicated.\n\n'
                      '6. Data & Privacy\n'
                      'We collect minimal data necessary to provide our services. Your email and name are stored securely. We do not sell or share your personal information with third parties.\n\n'
                      '7. Saved Prompts\n'
                      'Your saved prompts are stored locally and on our cloud servers. We are not responsible for any data loss. Please keep backups of important prompts.\n\n'
                      '8. Disclaimer\n'
                      'Nexora is provided "as is" without warranty of any kind. We do not guarantee that the AI prompts will produce specific results on any AI platform.\n\n'
                      '9. Limitation of Liability\n'
                      'In no event shall Nexora be liable for any indirect, incidental, special, consequential, or punitive damages resulting from your use of the application.\n\n'
                      '10. Changes to Terms\n'
                      'We reserve the right to modify these terms at any time. Continued use of the app after changes constitutes acceptance of the new terms.\n\n'
                      '11. Contact\n'
                      'If you have any questions about these Terms & Conditions, please contact us at support@nexora.com.',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    height: 1.7,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() => _agreedToTerms = true);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.royalBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'I AGREE TO THE TERMS',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(height: 20),

                // ─── Back Button ───
                FadeTransition(
                  opacity: _fadeAnim,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.lightInput,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppColors.border.withOpacity(0.5),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: theme.textTheme.bodyLarge?.color,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ─── Header ───
                FadeTransition(
                  opacity: _fadeAnim,
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.buttonGradient,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.royalBlue.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.person_add_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 20),
                      GradientText(
                        text: 'Create Account',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ) ?? GoogleFonts.inter(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                        gradient: AppColors.textGradient,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Join our community of AI creators',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 36),

                // ─── Form Fields ───
                SlideTransition(
                  position: _slideAnim,
                  child: FadeTransition(
                    opacity: _fadeAnim,
                    child: Column(
                      children: [
                        CustomTextField(
                          hint: 'Full Name',
                          prefixIcon: Icons.person_outline_rounded,
                          controller: _nameCtrl,
                          validator: Validators.name,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          hint: 'Email Address',
                          prefixIcon: Icons.email_outlined,
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          validator: Validators.email,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          hint: 'Password',
                          prefixIcon: Icons.lock_outline_rounded,
                          isPassword: true,
                          controller: _passCtrl,
                          validator: Validators.password,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          hint: 'Confirm Password',
                          prefixIcon: Icons.shield_outlined,
                          isPassword: true,
                          controller: _confirmCtrl,
                          validator: (v) =>
                              Validators.confirmPassword(v, _passCtrl.text),
                        ),
                        const SizedBox(height: 20),

                        // ─── Terms Checkbox ───
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => setState(
                                      () => _agreedToTerms = !_agreedToTerms),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: _agreedToTerms
                                        ? AppColors.royalBlue
                                        : AppColors.border,
                                    width: 2,
                                  ),
                                  color: _agreedToTerms
                                      ? AppColors.royalBlue
                                      : Colors.transparent,
                                ),
                                child: _agreedToTerms
                                    ? const Icon(Icons.check_rounded,
                                    size: 16, color: Colors.white)
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _showTermsAndConditions(),
                                child: RichText(
                                  text: TextSpan(
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                    children: [
                                      const TextSpan(text: 'I agree to the '),
                                      TextSpan(
                                        text: 'Terms & Conditions',
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          color: AppColors.royalBlue,
                                          fontWeight: FontWeight.w800,
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                          AppColors.royalBlue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // ─── SEND OTP Button ───
                        CustomButton(
                          text: _isSendingOTP ? 'SENDING OTP...' : 'VERIFY EMAIL',
                          icon: Icons.email_outlined,
                          isLoading: _isSendingOTP,
                          onPressed: _signup,
                        ),

                        const SizedBox(height: 24),

                        // ─── Footer Link ───
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Text(
                                'Login',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: AppColors.royalBlue,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}