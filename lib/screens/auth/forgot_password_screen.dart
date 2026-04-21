import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../utils/validators.dart';
import '../../widgets/common/gradient_text.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  bool _emailSent = false;

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = Provider.of<AuthProvider>(context, listen: false);
    final success = await auth.sendPasswordResetEmail(_emailCtrl.text.trim());

    if (!mounted) return;

    if (success) {
      setState(() => _emailSent = true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(auth.error ?? 'Error sending reset email'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.lightInput,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border.withOpacity(0.5)),
              ),
              child: const Icon(
                Icons.arrow_back_rounded, 
                color: AppColors.textPrimary, 
                size: 20
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: FadeTransition(
            opacity: _fadeAnim,
            child: SlideTransition(
              position: _slideAnim,
              child: _emailSent ? _buildSuccessState(theme) : _buildFormState(auth, theme),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormState(AuthProvider auth, ThemeData theme) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.royalBlue.withOpacity(0.1),
            ),
            child: const Icon(Icons.lock_reset_rounded, color: AppColors.royalBlue, size: 40),
          ),
          const SizedBox(height: 24),
          GradientText(
            text: 'Reset Password',
            gradient: AppColors.textGradient,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ) ?? GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          Text(
            'Enter your email and we\'ll send you a link to reset your password.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 40),
          CustomTextField(
            hint: 'Email Address',
            prefixIcon: Icons.email_outlined,
            controller: _emailCtrl,
            validator: Validators.email,
          ),
          const SizedBox(height: 32),
          CustomButton(
            text: 'SEND RESET LINK',
            isLoading: auth.isLoading,
            onPressed: _resetPassword,
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Back to Login',
              style: GoogleFonts.inter(
                color: AppColors.royalBlue,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline_rounded, color: Colors.blue.shade700, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'The reset link will expire in 1 hour. Check your spam folder if you don\'t see the email.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSuccessState(ThemeData theme) {
    return Column(
      children: [
        const SizedBox(height: 40),
        const Icon(Icons.mark_email_read_rounded, color: Colors.green, size: 80),
        const SizedBox(height: 24),
        Text(
          'Check Your Email',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        Text(
          'We have sent a password reset link to\n${_emailCtrl.text}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 40),
        CustomButton(
          text: 'BACK TO LOGIN',
          onPressed: () => Navigator.pop(context),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () => setState(() => _emailSent = false),
          child: Text(
            'Didn\'t receive the email? Try again',
            style: GoogleFonts.inter(color: AppColors.royalBlue, fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }
}
