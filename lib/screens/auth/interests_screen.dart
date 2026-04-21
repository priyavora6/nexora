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
import '../../utils/helpers.dart';

class InterestsSelectionScreen extends StatefulWidget {
  const InterestsSelectionScreen({Key? key}) : super(key: key);

  @override
  State<InterestsSelectionScreen> createState() =>
      _InterestsSelectionScreenState();
}

class _InterestsSelectionScreenState
    extends State<InterestsSelectionScreen> {
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
          SnackBar(
              content:
              Text(authProv.error ?? "Failed to save interests")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final promptProv = Provider.of<PromptProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.lightScaffold,
      appBar:
      const GradientAppBar(title: 'PERSONALIZE', showBack: false),
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
                color: Color(0xFF7E57C2), // Changed to Professional Navy
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Text(
              "Select categories to build your custom feed.",
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textSecondary, // Changed to Muted Blue-Grey
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 30),

          /// 🔥 GRID
          Expanded(
            child: StreamBuilder(
              stream: promptProv.categoriesStream,
              builder: (context, snap) {
                if (!snap.hasData) {
                  return const Center(
                      child: CircularProgressIndicator());
                }

                final cats = snap.data!;

                return GridView.builder(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 22),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.45,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: cats.length,
                  itemBuilder: (context, i) {
                    final cat = cats[i];
                    final isSelected =
                    _selectedIds.contains(cat.id);

                    final color =
                    Helpers.hexToColor(cat.color);

                    return GestureDetector(
                      onTap: () => setState(() => isSelected
                          ? _selectedIds.remove(cat.id)
                          : _selectedIds.add(cat.id)),

                      child: AnimatedContainer(
                        duration:
                        const Duration(milliseconds: 250),

                        decoration: BoxDecoration(
                          color: isSelected
                              ? color.withOpacity(0.12)
                              : color.withOpacity(0.05),

                          borderRadius:
                          BorderRadius.circular(20),

                          border: Border.all(
                            color: color,
                            width: 1.4,
                          ),

                          boxShadow: isSelected
                              ? [
                            BoxShadow(
                              color: color.withOpacity(0.45),
                              blurRadius: 18,
                              spreadRadius: 1,
                              offset: const Offset(0, 6),
                            ),
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.05),
                              blurRadius: 6,
                              offset:
                              const Offset(0, 3),
                            ),
                          ]
                              : [],
                        ),

                        child: Center(
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(
                                horizontal: 10),

                            child: Text(
                              cat.name.toUpperCase(),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow:
                              TextOverflow.ellipsis,

                              style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1,

                                color: color,
                              ),
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

          /// 🔘 BUTTON
          Padding(
            padding: const EdgeInsets.all(26),
            child: CustomButton(
              text: 'FINISH SETUP',
              isLoading: _isSaving,
              onPressed:
              _selectedIds.isNotEmpty ? _handleFinish : null,
            ),
          ),
        ],
      ),
    );
  }
}
