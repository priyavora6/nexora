import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../models/category_model.dart';
import '../../providers/prompt_provider.dart';
import '../../services/firestore_service.dart';
import '../../utils/helpers.dart';
import '../../widgets/layout/gradient_app_bar.dart';

class ManageCategoriesScreen extends StatelessWidget {
  const ManageCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: GradientAppBar(
        title: 'Manage Categories',
        showBack: true,
        actions: [
          // ✅ Total count badge
          StreamBuilder<List<CategoryModel>>(
            stream: Provider.of<PromptProvider>(context).categoriesStream,
            builder: (context, snap) {
              final count = snap.data?.length ?? 0;
              return Center(
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$count',
                    style: GoogleFonts.raleway(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),

      // ✅ FAB to add new category
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.addEditCategory),
        backgroundColor: AppColors.lightCoral,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text(
          'Add Category',
          style: GoogleFonts.raleway(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),

      body: StreamBuilder<List<CategoryModel>>(
        stream: Provider.of<PromptProvider>(context).categoriesStream,
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.lightCoral),
            );
          }

          if (snap.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.folder_open_rounded,
                    size: 80,
                    color: AppColors.sage.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Categories Yet',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to add your first category',
                    style: GoogleFonts.raleway(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            itemCount: snap.data!.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) {
              final cat = snap.data![i];
              return _CategoryManageTile(category: cat);
            },
          );
        },
      ),
    );
  }
}

// ─── CATEGORY MANAGE TILE ───
class _CategoryManageTile extends StatelessWidget {
  final CategoryModel category;

  const _CategoryManageTile({required this.category});

  @override
  Widget build(BuildContext context) {
    final color = Helpers.hexToColor(category.color);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // ─── Main Info Row ───
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: color.withOpacity(0.3)),
                  ),
                  child: Center(
                    child: Text(
                      category.icon,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Name & Stats
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.name,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          // Prompt Count
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${category.promptCount} prompts',
                              style: GoogleFonts.raleway(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: color,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Color Dot
                          Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: color.withOpacity(0.4),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            category.color.toUpperCase(),
                            style: GoogleFonts.raleway(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textHint,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ─── Divider ───
          Divider(
            height: 1,
            color: AppColors.border.withOpacity(0.3),
          ),

          // ─── Action Buttons Row ───
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                // 🔥 View Subcategories (UPDATED TO ADMIN ROUTE) 🔥
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRoutes.managePrompts, // ✅ Changed this to your Admin route!
                      arguments: {
                        'categoryId': category.id,
                        'categoryName': category.name,
                        'categoryColor': category.color,
                      },
                    ),
                    icon: Icon(
                      Icons.visibility_rounded,
                      size: 18,
                      color: AppColors.sage,
                    ),
                    label: Text(
                      'View',
                      style: GoogleFonts.raleway(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.sage,
                      ),
                    ),
                  ),
                ),

                // Edit
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRoutes.addEditCategory,
                      arguments: {'category': category},
                    ),
                    icon: Icon(
                      Icons.edit_rounded,
                      size: 18,
                      color: AppColors.lightCoral,
                    ),
                    label: Text(
                      'Edit',
                      style: GoogleFonts.raleway(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.lightCoral,
                      ),
                    ),
                  ),
                ),

                // Delete
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => _deleteCategory(context),
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      size: 18,
                      color: AppColors.error,
                    ),
                    label: Text(
                      'Delete',
                      style: GoogleFonts.raleway(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteCategory(BuildContext context) async {
    final confirm = await Helpers.showConfirmDialog(
      context,
      title: 'Delete Category',
      message:
      '⚠️ This will permanently delete "${category.name}" and all its prompts.\n\nThis cannot be undone!',
      confirmText: 'Delete',
      confirmColor: AppColors.error,
    );

    if (confirm) {
      try {
        await FirestoreService().deleteCategory(category.id);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${category.name} deleted'),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    }
  }
}