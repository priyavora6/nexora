// lib/screens/auth/interests_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../providers/auth_provider.dart';
import '../../providers/prompt_provider.dart';
import '../../widgets/layout/gradient_app_bar.dart';
import '../../widgets/common/custom_button.dart';

class InterestsSelectionScreen extends StatefulWidget {
  const InterestsSelectionScreen({Key? key}) : super(key: key);

  @override
  State<InterestsSelectionScreen> createState() => _InterestsSelectionScreenState();
}

class _InterestsSelectionScreenState extends State<InterestsSelectionScreen> {
  final List<String> _selectedIds = [];
  bool _isSaving = false;

  Future<void> _handleFinish() async {
    if (_selectedIds.isEmpty) return;

    setState(() => _isSaving = true);

    final authProv = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProv.updateUserInterests(_selectedIds);

    if (mounted) {
      setState(() => _isSaving = false);
      if (success) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authProv.error ?? "Failed to save interests")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final promptProv = Provider.of<PromptProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.lightScaffold,
      appBar: const GradientAppBar(title: 'PERSONALIZE', showBack: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 40, 28, 10),
            child: Text(
              "PICK YOUR\nINTERESTS",
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                height: 1.1,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Text(
              "Select categories to build your custom feed.",
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: StreamBuilder(
              stream: promptProv.categoriesStream,
              builder: (context, snap) {
                if (!snap.hasData) return const Center(child: CircularProgressIndicator());
                final cats = snap.data!;
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: cats.length,
                  itemBuilder: (context, i) {
                    final isSelected = _selectedIds.contains(cats[i].id);
                    return GestureDetector(
                      onTap: () => setState(() => isSelected
                          ? _selectedIds.remove(cats[i].id)
                          : _selectedIds.add(cats[i].id)),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.royalBlue : AppColors.lightInput,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isSelected ? AppColors.royalBlue : AppColors.border,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            cats[i].name.toUpperCase(),
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: isSelected ? Colors.white : AppColors.textPrimary,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28),
            child: CustomButton(
              text: 'FINISH SETUP',
              isLoading: _isSaving,
              onPressed: _selectedIds.isNotEmpty ? _handleFinish : null,
            ),
          ),
        ],
      ),
    );
  }
}
