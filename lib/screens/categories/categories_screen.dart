import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../models/category_model.dart';
import '../../providers/prompt_provider.dart';
import '../../widgets/layout/bottom_nav_bar.dart';
import '../../widgets/layout/gradient_app_bar.dart';
import '../../utils/helpers.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  void _goToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PromptProvider>(context);
    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        _goToHome(context);
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,

        appBar: GradientAppBar(
          title: 'CATEGORIES',
          showBack: true,
          onBackPressed: () => _goToHome(context),
        ),

        bottomNavigationBar: const BottomNavBar(currentIndex: 1),

        body: StreamBuilder<List<CategoryModel>>(
          stream: prov.categoriesStream,
          builder: (context, snap) {
            if (!snap.hasData) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.royalBlue),
              );
            }

            if (snap.data!.isEmpty) {
              return Center(
                child: Text(
                  'No Categories Yet',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.5, // Made it shorter since icon is removed
              ),
              itemCount: snap.data!.length,
              itemBuilder: (_, i) {
                final cat = snap.data![i];
                return _CategoryCard(
                  category: cat,
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.categoryDetail,
                    arguments: {
                      'categoryId': cat.id,
                      'categoryName': cat.name,
                      'categoryColor': cat.color,
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// ─── CATEGORY CARD WIDGET ───
class _CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = Helpers.hexToColor(category.color);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(color: color.withOpacity(0.1), width: 1),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              category.name.toUpperCase(),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 12,
                letterSpacing: 0.5,
                color: color.withOpacity(0.8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
