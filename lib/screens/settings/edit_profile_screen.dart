// lib/screens/settings/edit_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/layout/gradient_app_bar.dart';
import '../../widgets/common/nexora_background.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;

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
    final auth = Provider.of<AuthProvider>(context, listen: false);
    _nameController = TextEditingController(text: auth.userName);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = Provider.of<AuthProvider>(context, listen: false);
    HapticFeedback.mediumImpact();

    final success = await auth.updateUserProfile(
      name: _nameController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Profile updated successfully!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(auth.error ?? '❌ Failed to update profile'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

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
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const GradientAppBar(
        title: 'EDIT PROFILE',
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
                  _animatedItem(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'YOUR\nPROFILE',
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
                          'Update your personal information below.',
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
                  _animatedItem(
                    delay: 100,
                    child: _buildTextField(
                      context,
                      controller: _nameController,
                      label: 'FULL NAME',
                      hint: 'Enter your name',
                      icon: Icons.person_outline_rounded,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _animatedItem(
                    delay: 200,
                    child: _buildReadOnlyField(
                      context,
                      label: 'EMAIL ADDRESS',
                      value: auth.userEmail,
                      icon: Icons.email_outlined,
                    ),
                  ),
                  const SizedBox(height: 60),
                  _animatedItem(
                    delay: 300,
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
                        onPressed: auth.isLoading ? null : _handleSave,
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
                                'SAVE CHANGES',
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

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
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
            validator: (val) =>
                val == null || val.isEmpty ? 'Name cannot be empty' : null,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: theme.textTheme.bodyLarge?.color,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5)),
              prefixIcon: Icon(icon, size: 22, color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5)),
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
                borderSide: BorderSide(
                    color: theme.dividerColor.withOpacity(isDark ? 0.1 : 0.5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReadOnlyField(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
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
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            color: isDark ? theme.colorScheme.surfaceVariant.withOpacity(0.3) : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: theme.dividerColor.withOpacity(isDark ? 0.1 : 0.5)),
          ),
          child: Row(
            children: [
              Icon(icon, size: 22, color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5)),
              const SizedBox(width: 12),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
                ),
              ),
              const Spacer(),
              Icon(Icons.lock_outline_rounded, size: 16, color: theme.colorScheme.onSurfaceVariant.withOpacity(0.4)),
            ],
          ),
        ),
      ],
    );
  }
}
