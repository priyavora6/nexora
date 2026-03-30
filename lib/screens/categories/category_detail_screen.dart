import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../models/category_model.dart';
import '../../models/subcategory_model.dart';
import '../../providers/prompt_provider.dart';
import '../../services/firestore_service.dart';
import '../../utils/helpers.dart';
import '../../widgets/layout/bottom_nav_bar.dart';
import '../../widgets/layout/gradient_app_bar.dart';
import '../../widgets/example_gallery_widget.dart';
import '../../widgets/prompt_thumbnail_widget.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String categoryId, categoryName, categoryColor;

  const CategoryDetailScreen({
    Key? key,
    required this.categoryId,
    required this.categoryName,
    required this.categoryColor,
  }) : super(key: key);

  void _handleBack(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PromptProvider>(context);
    final theme = Theme.of(context);
    final color = Helpers.hexToColor(categoryColor);

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        _handleBack(context);
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: GradientAppBar(
          title: categoryName.toUpperCase(),
          showBack: true,
          onBackPressed: () => _handleBack(context),
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 1),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: double.infinity, height: 3, color: color.withOpacity(0.1)),

              FutureBuilder<CategoryModel?>(
                future: _getCategory(),
                builder: (context, snap) {
                  if (snap.hasData && snap.data!.hasHeroExamples) {
                    return Column(
                      children: [
                        const SizedBox(height: 24),
                        ExampleGalleryWidget(
                          exampleUrls: snap.data!.heroExampleUrls,
                          exampleTypes: snap.data!.heroExampleTypes,
                          height: 250,
                          showIndicator: true,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Showcase examples from this category'.toUpperCase(),
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 10,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textHint,
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox(height: 16);
                },
              ),

              const SizedBox(height: 24),

              FutureBuilder<CategoryModel?>(
                future: _getCategory(),
                builder: (context, snap) {
                  if (snap.hasData && snap.data!.description.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snap.data!.description,
                            style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SELECT A STYLE',
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    StreamBuilder<List<SubcategoryModel>>(
                      stream: prov.subcategoriesStream(categoryId),
                      builder: (context, snap) {
                        if (!snap.hasData) return const SizedBox.shrink();
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${snap.data!.length} STYLES',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: color,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              StreamBuilder<List<SubcategoryModel>>(
                stream: prov.subcategoriesStream(categoryId),
                builder: (context, snap) {
                  if (!snap.hasData) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: CircularProgressIndicator(color: AppColors.royalBlue),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    itemCount: snap.data!.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      final sub = snap.data![i];
                      return _SubcategoryTile(
                        subcategory: sub,
                        categoryColor: color,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.subcategoryDetail,
                          arguments: {
                            'categoryId': categoryId,
                            'categoryName': categoryName,
                            'subcategoryId': sub.id,
                            'subcategoryName': sub.name,
                            'categoryColor': categoryColor,
                          },
                        ),
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Future<CategoryModel?> _getCategory() async {
    final categories = await FirestoreService()
        .getCategories()
        .first;

    return categories.firstWhere(
          (cat) => cat.id == categoryId,
      orElse: () => CategoryModel(
        id: categoryId,
        name: categoryName,
        icon: '📁',
        color: categoryColor,
      ),
    );
  }
}

class _SubcategoryTile extends StatelessWidget {
  final SubcategoryModel subcategory;
  final Color categoryColor;
  final VoidCallback onTap;

  const _SubcategoryTile({
    required this.subcategory,
    required this.categoryColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightInput,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            if (subcategory.hasFeaturedExample) ...[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: PromptThumbnailWidget(
                  imageUrl: subcategory.featuredExampleUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  showPlayIcon: subcategory.hasFeaturedVideo,
                ),
              ),
              const SizedBox(width: 16),
            ],

            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: subcategory.hasFeaturedExample ? 0 : 20, // Add padding if no image
                  top: 18,
                  bottom: 18,
                  right: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subcategory.name.toUpperCase(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                    if (subcategory.promptCount > 0) ...[
                      const SizedBox(height: 4),
                      Text(
                        '${subcategory.promptCount} PROMPTS',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textHint,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(right: 18),
              child: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.lavender),
            ),
          ],
        ),
      ),
    );
  }
}
