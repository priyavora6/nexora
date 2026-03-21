import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // ✅ Using Poppins
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../models/prompt_model.dart';
import '../../providers/prompt_provider.dart';
import '../../utils/helpers.dart';
import '../../widgets/cards/prompt_card.dart';
import '../../widgets/layout/bottom_nav_bar.dart';
import '../../widgets/layout/gradient_app_bar.dart';
import '../../widgets/common/particles_background.dart';

class SubcategoryDetailScreen extends StatelessWidget {
  final String categoryId, categoryName, subcategoryId, subcategoryName, categoryColor;

  const SubcategoryDetailScreen({
    Key? key,
    required this.categoryId,
    required this.categoryName,
    required this.subcategoryId,
    required this.subcategoryName,
    required this.categoryColor,
  }) : super(key: key);

  void _handleBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PromptProvider>(context);
    final color = Helpers.hexToColor(categoryColor);

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: GradientAppBar(
        title: subcategoryName, // Poppins will be applied here internally or via theme
        showBack: true,
        onBackPressed: () => _handleBack(context),
      ),

      bottomNavigationBar: const BottomNavBar(currentIndex: 1),

      body: Stack(
        children: [
          // ✅ Particles Background
          const ParticlesBackground(count: 20),

          Column(
            children: [
              // ─── THIN ACCENT LINE ───
              Container(
                width: double.infinity,
                height: 3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.1)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),

              // ─── PROMPTS LIST ───
              Expanded(
                child: StreamBuilder<List<PromptModel>>(
                  stream: prov.promptsBySubcategory(categoryId, subcategoryId),
                  builder: (context, snap) {
                    if (!snap.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(color: AppColors.lightCoral),
                      );
                    }

                    if (snap.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'No prompts found in this collection',
                          style: GoogleFonts.poppins( // ✅ Changed to Poppins
                            color: AppColors.textHint,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                      physics: const BouncingScrollPhysics(),
                      itemCount: snap.data!.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (_, i) {
                        final prompt = snap.data![i];
                        return PromptCard(
                          prompt: prompt,
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.promptDetail,
                            arguments: {'promptId': prompt.id},
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}