// lib/screens/settings/change_password_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/layout/gradient_app_bar.dart';
import '../../widgets/common/nexora_background.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with SingleTickerProviderStateMixin {

  final _formKey = GlobalKey<FormState>();

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  );

  late final Animation<double> _fadeAnimation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = Provider.of<AuthProvider>(context, listen: false);

    HapticFeedback.mediumImpact();

    final success = await auth.changePassword(
      currentPassword: _currentPasswordController.text.trim(),
      newPassword: _newPasswordController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Password updated successfully!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(auth.error ?? '❌ Failed to update password'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  /// 🔥 Smooth stagger animation
  Widget _animatedItem({required Widget child, int delay = 0}) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + delay),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, 30 * (1.0 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const GradientAppBar(
        title: 'SECURITY',
        showBack: true,
      ),
      body: NexoraBackground(
        particleCount: 18,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// 🔥 HEADER
                  _animatedItem(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CHANGE\nPASSWORD',
                          style: GoogleFonts.inter(
                            fontSize: 36, 
                            fontWeight: FontWeight.w900,
                            height: 1.1,
                            color: theme.textTheme.displayLarge?.color,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Keep your account secure with a strong password.',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: theme.textTheme.bodyMedium?.color,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 48),

                  /// 🔐 CURRENT PASSWORD
                  _animatedItem(
                    delay: 100,
                    child: _buildPasswordField(
                      context,
                      controller: _currentPasswordController,
                      label: 'CURRENT PASSWORD',
                      obscure: _obscureCurrent,
                      onToggle: () =>
                          setState(() => _obscureCurrent = !_obscureCurrent),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// 🔐 NEW PASSWORD
                  _animatedItem(
                    delay: 200,
                    child: _buildPasswordField(
                      context,
                      controller: _newPasswordController,
                      label: 'NEW PASSWORD',
                      obscure: _obscureNew,
                      onToggle: () =>
                          setState(() => _obscureNew = !_obscureNew),
                      validator: (val) {
                        if (val == null || val.length < 6) {
                          return 'Minimum 6 characters required';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// 🔐 CONFIRM PASSWORD
                  _animatedItem(
                    delay: 300,
                    child: _buildPasswordField(
                      context,
                      controller: _confirmPasswordController,
                      label: 'CONFIRM PASSWORD',
                      obscure: _obscureConfirm,
                      onToggle: () =>
                          setState(() => _obscureConfirm = !_obscureConfirm),
                      validator: (val) {
                        if (val != _newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 60),

                  /// 🚀 BUTTON
                  _animatedItem(
                    delay: 400,
                    child: Container(
                      width: double.infinity,
                      height: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: AppColors.primaryGradient,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.35),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed:
                        auth.isLoading ? null : _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: auth.isLoading
                            ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                            : Text(
                          'UPDATE PASSWORD',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 🔐 PASSWORD FIELD UI
  Widget _buildPasswordField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required bool obscure,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 10),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: theme.textTheme.bodyMedium?.color,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscure,
            validator: validator ??
                    (val) =>
                val == null || val.isEmpty ? 'Required field' : null,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: theme.textTheme.bodyLarge?.color,
            ),
            decoration: InputDecoration(
              hintText: '••••••••',
              hintStyle: TextStyle(color: theme.textTheme.bodyMedium?.color?.withOpacity(0.3), fontSize: 18),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  icon: Icon(
                    obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 22,
                    color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
                  ),
                  onPressed: onToggle,
                ),
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              filled: true,
              fillColor: theme.cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide:
                BorderSide(color: theme.dividerColor.withOpacity(isDark ? 0.1 : 0.5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide:
                const BorderSide(color: Colors.redAccent, width: 1.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide:
                const BorderSide(color: Colors.redAccent, width: 2.0),
              ),
              errorStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
