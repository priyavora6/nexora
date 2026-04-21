import 'package:flutter/material.dart';
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: GradientAppBar(
        title: 'MANAGE CATEGORIES',
        showBack: true,
        actions: [
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
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.addEditCategory),
        backgroundColor: AppColors.royalBlue,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text('ADD CATEGORY', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 0.5)),
      ),
      body: StreamBuilder<List<CategoryModel>>(
        stream: Provider.of<PromptProvider>(context).categoriesStream,
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator(color: AppColors.royalBlue));
          }

          if (snap.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.folder_open_rounded, size: 80, color: AppColors.lavender.withOpacity(0.5)),
                  const SizedBox(height: 16),
                  Text('NO CATEGORIES YET', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
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
              return _CategoryManageTile(category: cat, theme: theme);
            },
          );
        },
      ),
    );
  }
}

class _CategoryManageTile extends StatelessWidget {
  final CategoryModel category;
  final ThemeData theme;

  const _CategoryManageTile({required this.category, required this.theme});

  @override
  Widget build(BuildContext context) {
    final color = Helpers.hexToColor(category.color);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 52, height: 52,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: color.withOpacity(0.3)),
                  ),
                  child: Center(child: Text(category.icon, style: const TextStyle(fontSize: 24))),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.name.toUpperCase(), // ✅ Uppercase
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w800, letterSpacing: 0.2),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              '${category.promptCount} PROMPTS', // ✅ Uppercase
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: color),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 12, height: 12,
                            decoration: BoxDecoration(color: color, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 1.5)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.border.withOpacity(0.3)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                _actionBtn(context, 'VIEW', Icons.visibility_rounded, AppColors.lavender, () => Navigator.pushNamed(context, AppRoutes.managePrompts, arguments: {'categoryId': category.id, 'categoryName': category.name, 'categoryColor': category.color})),
                _actionBtn(context, 'EDIT', Icons.edit_rounded, AppColors.royalBlue, () => Navigator.pushNamed(context, AppRoutes.addEditCategory, arguments: {'category': category})),
                _actionBtn(context, 'DELETE', Icons.delete_outline_rounded, AppColors.error, () => _deleteCategory(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionBtn(BuildContext context, String label, IconData icon, Color color, VoidCallback onTap) {
    return Expanded(
      child: TextButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 16, color: color),
        label: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: color, letterSpacing: 0.5)),
      ),
    );
  }

  Future<void> _deleteCategory(BuildContext context) async {
    final confirm = await Helpers.showConfirmDialog(context, title: 'DELETE CATEGORY', message: 'This will permanently delete "${category.name}".', confirmText: 'DELETE', confirmColor: AppColors.error);
    if (confirm) {
      await FirestoreService().deleteCategory(category.id);
    }
  }
}