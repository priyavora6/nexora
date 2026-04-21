import 'package:flutter/material.dart';
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: GradientAppBar(
        title: 'MANAGE PROMPTS',
        showBack: true,
        actions: [
          StreamBuilder<List<PromptModel>>(
            stream: promptProv.promptsStream,
            builder: (context, snap) {
              final count = snap.data?.length ?? 0;
              return Center(
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                  child: Text('$count', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.white)),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.addEditPrompt),
        backgroundColor: AppColors.royalBlue,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text('ADD PROMPT', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 0.5)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
              decoration: InputDecoration(
                hintText: 'SEARCH PROMPTS...',
                prefixIcon: const Icon(Icons.search_rounded, color: AppColors.royalBlue),
                suffixIcon: _searchQuery.isNotEmpty ? IconButton(icon: const Icon(Icons.clear_rounded), onPressed: () { _searchCtrl.clear(); setState(() => _searchQuery = ''); }) : null,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<PromptModel>>(
              stream: promptProv.promptsStream,
              builder: (context, snap) {
                if (!snap.hasData) return const Center(child: CircularProgressIndicator(color: AppColors.royalBlue));
                final prompts = _searchQuery.isEmpty ? snap.data! : snap.data!.where((p) => p.title.toLowerCase().contains(_searchQuery) || p.platform.toLowerCase().contains(_searchQuery)).toList();
                if (prompts.isEmpty) return Center(child: Text('NO PROMPTS FOUND', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)));
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                  itemCount: prompts.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) => _PromptManageTile(prompt: prompts[i], theme: theme),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PromptManageTile extends StatelessWidget {
  final PromptModel prompt;
  final ThemeData theme;

  const _PromptManageTile({required this.prompt, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.4)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(prompt.title.toUpperCase(), style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w800, letterSpacing: 0.2)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8, runSpacing: 8,
                  children: [
                    _badge(prompt.platform.toUpperCase(), AppColors.royalBlue),
                    if (prompt.categoryName.isNotEmpty) _badge(prompt.categoryName.toUpperCase(), AppColors.lavender),
                  ],
                ),
                const SizedBox(height: 10),
                Text(prompt.text, maxLines: 2, overflow: TextOverflow.ellipsis, style: theme.textTheme.bodySmall?.copyWith(height: 1.4)),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.border.withOpacity(0.3)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                _actionBtn('VIEW', Icons.visibility_rounded, AppColors.lavender, () => Navigator.pushNamed(context, AppRoutes.promptDetail, arguments: {'promptId': prompt.id})),
                _actionBtn('EDIT', Icons.edit_rounded, AppColors.royalBlue, () => Navigator.pushNamed(context, AppRoutes.addEditPrompt, arguments: {'prompt': prompt})),
                _actionBtn('DELETE', Icons.delete_outline_rounded, AppColors.error, () => _deletePrompt(context)),
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
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: color.withOpacity(0.3))),
      child: Text(text, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: color, letterSpacing: 0.5)),
    );
  }

  Widget _actionBtn(String label, IconData icon, Color color, VoidCallback onTap) {
    return Expanded(
      child: TextButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 16, color: color),
        label: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: color, letterSpacing: 0.5)),
      ),
    );
  }

  Future<void> _deletePrompt(BuildContext context) async {
    final confirm = await Helpers.showConfirmDialog(context, title: 'DELETE PROMPT', message: 'Are you sure you want to delete "${prompt.title}"?', confirmText: 'DELETE', confirmColor: AppColors.error);
    if (confirm) {
      await FirestoreService().deletePrompt(prompt.id);
    }
  }
}