import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../models/prompt_model.dart';
import '../../models/subcategory_model.dart';
import '../../providers/prompt_provider.dart';
import '../../services/firestore_service.dart';
import '../../utils/helpers.dart';
import '../../widgets/cards/prompt_card.dart';
import '../../widgets/layout/bottom_nav_bar.dart';
import '../../widgets/layout/gradient_app_bar.dart';
import '../../widgets/prompt_thumbnail_widget.dart';
import '../../widgets/video_player_widget.dart';

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
    final theme = Theme.of(context);
    final color = Helpers.hexToColor(categoryColor);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: GradientAppBar(
        title: subcategoryName.toUpperCase(), 
        showBack: true,
        onBackPressed: () => _handleBack(context),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

            FutureBuilder<SubcategoryModel?>(
              future: _getSubcategory(),
              builder: (context, snap) {
                if (snap.hasData && snap.data!.hasFeaturedExample) {
                  return _buildFeaturedSection(context, snap.data!, color, theme);
                }
                return const SizedBox(height: 16);
              },
            ),

            FutureBuilder<SubcategoryModel?>(
              future: _getSubcategory(),
              builder: (context, snap) {
                if (snap.hasData && snap.data!.description.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                    child: Text(
                      snap.data!.description,
                      style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              child: StreamBuilder<List<PromptModel>>(
                stream: prov.promptsBySubcategory(categoryId, subcategoryId),
                builder: (context, snap) {
                  final count = snap.hasData ? snap.data!.length : 0;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ALL PROMPTS',
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: color.withOpacity(0.3)),
                        ),
                        child: Text(
                          '$count PROMPTS',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            StreamBuilder<List<PromptModel>>(
              stream: prov.promptsBySubcategory(categoryId, subcategoryId),
              builder: (context, snap) {
                if (!snap.hasData) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: CircularProgressIndicator(color: AppColors.royalBlue),
                    ),
                  );
                }

                if (snap.data!.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: [
                          Icon(
                            Icons.inbox_outlined,
                            size: 64,
                            color: AppColors.textHint.withOpacity(0.3),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'NO PROMPTS FOUND',
                            style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final sortedPrompts = List<PromptModel>.from(snap.data!);
                sortedPrompts.sort((a, b) {
                  if (a.isFeatured && !b.isFeatured) return -1;
                  if (!a.isFeatured && b.isFeatured) return 1;
                  return 0;
                });

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                  itemCount: sortedPrompts.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, i) {
                    final prompt = sortedPrompts[i];
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
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedSection(BuildContext context, SubcategoryModel subcategory, Color color, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2), width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: Row(
              children: [
                Icon(Icons.auto_awesome, size: 16, color: color),
                const SizedBox(width: 8),
                Text(
                  'FEATURED EXAMPLE',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: color,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),

          ClipRRect(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(18)),
            child: subcategory.hasFeaturedVideo
                ? VideoPlayerWidget(
              videoUrl: subcategory.featuredExampleUrl!,
              autoPlay: false,
              showControls: true,
            )
                : PromptThumbnailWidget(
              imageUrl: subcategory.featuredExampleUrl,
              height: 220,
              fit: BoxFit.cover,
              showPlayIcon: false,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'THIS IS WHAT YOU CAN CREATE ✨',
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 10,
                color: AppColors.textSecondary.withOpacity(0.7),
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<SubcategoryModel?> _getSubcategory() async {
    try {
      final subcategories = await FirestoreService()
          .getSubcategoriesList(categoryId);

      return subcategories.firstWhere(
            (sub) => sub.id == subcategoryId,
        orElse: () => SubcategoryModel(
          id: subcategoryId,
          name: subcategoryName,
          icon: '📁',
          order: 0,
          promptCount: 0,
        ),
      );
    } catch (e) {
      debugPrint('Error fetching subcategory: $e');
      return null;
    }
  }
}
