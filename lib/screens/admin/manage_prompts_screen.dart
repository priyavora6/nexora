import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../models/prompt_model.dart';
import '../../providers/prompt_provider.dart';
import '../../services/firestore_service.dart';
import '../../utils/helpers.dart';
import '../../widgets/layout/gradient_app_bar.dart';

class ManagePromptsScreen extends StatefulWidget {
  const ManagePromptsScreen({Key? key}) : super(key: key);

  @override
  State<ManagePromptsScreen> createState() => _ManagePromptsScreenState();
}

class _ManagePromptsScreenState extends State<ManagePromptsScreen> {
  String _searchQuery = '';
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final promptProv = Provider.of<PromptProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: GradientAppBar(
        title: 'Manage Prompts',
        showBack: true,
        actions: [
          // ✅ Total count badge
          StreamBuilder<List<PromptModel>>(
            stream: promptProv.promptsStream,
            builder: (context, snap) {
              final count = snap.data?.length ?? 0;
              return Center(
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
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

      // ✅ FAB to add new prompt
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.addEditPrompt),
        backgroundColor: AppColors.lightCoral,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text(
          'Add Prompt',
          style: GoogleFonts.raleway(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),

      body: Column(
        children: [
          // ─── SEARCH BAR ───
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'Search prompts...',
                hintStyle: GoogleFonts.raleway(
                  color: AppColors.textHint,
                  fontSize: 13,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.sage,
                  size: 20,
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                  icon: const Icon(
                    Icons.clear_rounded,
                    color: AppColors.textHint,
                    size: 20,
                  ),
                  onPressed: () {
                    _searchCtrl.clear();
                    setState(() => _searchQuery = '');
                  },
                )
                    : null,
                filled: true,
                fillColor: AppColors.lightInput,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
              ),
            ),
          ),

          // ─── PROMPTS LIST ───
          Expanded(
            child: StreamBuilder<List<PromptModel>>(
              stream: promptProv.promptsStream,
              builder: (context, snap) {
                if (!snap.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.lightCoral,
                    ),
                  );
                }

                // ✅ Filter by search
                final allPrompts = snap.data!;
                final prompts = _searchQuery.isEmpty
                    ? allPrompts
                    : allPrompts.where((p) {
                  return p.title.toLowerCase().contains(_searchQuery) ||
                      p.platform.toLowerCase().contains(_searchQuery) ||
                      p.categoryName.toLowerCase().contains(_searchQuery) ||
                      p.subcategoryName.toLowerCase().contains(_searchQuery);
                }).toList();

                if (prompts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _searchQuery.isNotEmpty
                              ? Icons.search_off_rounded
                              : Icons.note_alt_outlined,
                          size: 64,
                          color: AppColors.sage.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _searchQuery.isNotEmpty
                              ? 'No matching prompts'
                              : 'No Prompts Yet',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _searchQuery.isNotEmpty
                              ? 'Try different keywords'
                              : 'Tap + to add your first prompt',
                          style: GoogleFonts.raleway(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                  itemCount: prompts.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) {
                    final p = prompts[i];
                    return _PromptManageTile(prompt: p);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── PROMPT MANAGE TILE ───
class _PromptManageTile extends StatelessWidget {
  final PromptModel prompt;

  const _PromptManageTile({required this.prompt});

  @override
  Widget build(BuildContext context) {
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
          // ─── Main Info ───
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  prompt.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 10),

                // Tags Row
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    // Platform Badge
                    _badge(
                      prompt.platform,
                      AppColors.lightCoral,
                    ),

                    // Category Badge
                    if (prompt.categoryName.isNotEmpty)
                      _badge(
                        prompt.categoryName,
                        AppColors.sage,
                      ),

                    // Subcategory Badge
                    if (prompt.subcategoryName.isNotEmpty)
                      _badge(
                        prompt.subcategoryName,
                        AppColors.sweetPeony,
                      ),
                  ],
                ),

                const SizedBox(height: 10),

                // Preview text
                Text(
                  prompt.text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.raleway(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
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

          // ─── Action Buttons ───
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                // View
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRoutes.promptDetail,
                      arguments: {'promptId': prompt.id},
                    ),
                    icon: const Icon(
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
                      AppRoutes.addEditPrompt,
                      arguments: {'prompt': prompt},
                    ),
                    icon: const Icon(
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
                    onPressed: () => _deletePrompt(context),
                    icon: const Icon(
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

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: GoogleFonts.raleway(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }

  Future<void> _deletePrompt(BuildContext context) async {
    final confirm = await Helpers.showConfirmDialog(
      context,
      title: 'Delete Prompt',
      message: '⚠️ Are you sure you want to delete "${prompt.title}"?\n\nThis cannot be undone!',
      confirmText: 'Delete',
      confirmColor: AppColors.error,
    );

    if (confirm) {
      try {
        await FirestoreService().deletePrompt(prompt.id);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('"${prompt.title}" deleted'),
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