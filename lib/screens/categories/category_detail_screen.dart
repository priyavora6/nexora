import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../models/subcategory_model.dart';
import '../../providers/prompt_provider.dart';
import '../../utils/helpers.dart';
import '../../widgets/layout/bottom_nav_bar.dart';
import '../../widgets/layout/gradient_app_bar.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String categoryId, categoryName, categoryColor;

  const CategoryDetailScreen({Key? key, required this.categoryId, required this.categoryName, required this.categoryColor}) : super(key: key);

  void _handleBack(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PromptProvider>(context);
    final color = Helpers.hexToColor(categoryColor);

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        _handleBack(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: GradientAppBar(
          title: categoryName.toLowerCase(),
          showBack: true,
          onBackPressed: () => _handleBack(context),
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 1),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: double.infinity, height: 3, color: color.withOpacity(0.1)),

            // ✅ Section Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: Text(
                'Select a Style',
                style: GoogleFonts.poppins(  // ✅ Changed
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            Expanded(
              child: StreamBuilder<List<SubcategoryModel>>(
                stream: prov.subcategoriesStream(categoryId),
                builder: (context, snap) {
                  if (!snap.hasData) return const Center(child: CircularProgressIndicator(color: AppColors.lightCoral));

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    itemCount: snap.data!.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      final sub = snap.data![i];
                      return _SubcategoryTile(
                        subcategory: sub,
                        categoryColor: color,
                        onTap: () => Navigator.pushNamed(context, AppRoutes.subcategoryDetail, arguments: {
                          'categoryId': categoryId, 'categoryName': categoryName,
                          'subcategoryId': sub.id, 'subcategoryName': sub.name, 'categoryColor': categoryColor,
                        }),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubcategoryTile extends StatelessWidget {
  final SubcategoryModel subcategory;
  final Color categoryColor;
  final VoidCallback onTap;

  const _SubcategoryTile({required this.subcategory, required this.categoryColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.lightInput,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Text(subcategory.icon, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                subcategory.name,
                style: GoogleFonts.poppins(  // ✅ Changed
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.sage),
          ],
        ),
      ),
    );
  }
}