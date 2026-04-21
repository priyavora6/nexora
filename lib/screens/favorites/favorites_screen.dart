import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../config/app_constants.dart';
import '../../models/prompt_model.dart';
import '../../providers/prompt_provider.dart';
import '../../services/firestore_service.dart';
import '../../widgets/cards/prompt_card.dart';
import '../../widgets/layout/bottom_nav_bar.dart';
import '../../widgets/layout/gradient_app_bar.dart';
import '../../widgets/common/nexora_background.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<PromptModel>? _prompts;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prov = Provider.of<PromptProvider>(context, listen: false);
    final favIds = prov.favoriteIds;

    if (favIds.isEmpty) {
      setState(() {
        _prompts = [];
        _isLoading = false;
      });
      return;
    }

    final service = FirestoreService();
    final List<PromptModel> prompts = [];
    for (var id in favIds) {
      final p = await service.getPrompt(id);
      if (p != null) prompts.add(p);
    }

    if (mounted) {
      setState(() {
        _prompts = prompts;
        _isLoading = false;
      });
    }
  }

  void _goToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
  }

  void _goToCategories(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.categories, (route) => false);
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
          title: 'SAVED',
          showBack: true,
          onBackPressed: () => _goToHome(context),
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 3),
        body: NexoraBackground(
          particleCount: 15,
          child: _isLoading
              ? const Center(child: CircularProgressIndicator(color: AppColors.royalBlue))
              : prov.favoriteIds.isEmpty || (_prompts != null && _prompts!.isEmpty)
              ? _buildEmptyState(theme)
              : _buildSavedList(prov, theme),
        ),
      ),
    );
  }

  Widget _buildSavedList(PromptProvider prov, ThemeData theme) {
    final prompts = _prompts ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${prompts.length} ITEMS SAVED', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900, letterSpacing: -0.5)),
                    Text('YOUR CURATED COLLECTION', style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w800, color: AppColors.royalBlue, fontSize: 10, letterSpacing: 1)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              TextButton(
                onPressed: () => _showClearAllDialog(context, prov), 
                child: const Text('CLEAR', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.w900, fontSize: 11))
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
            itemCount: prompts.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, i) {
              final p = prompts[i];
              return Dismissible(
                key: Key(p.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 25),
                  decoration: BoxDecoration(color: AppColors.error.withOpacity(0.1), borderRadius: BorderRadius.circular(24)),
                  child: const Icon(Icons.bookmark_remove_rounded, color: AppColors.error, size: 28),
                ),
                onDismissed: (_) { 
                  prov.toggleFavorite(p.id); 
                  setState(() { _prompts!.removeWhere((pr) => pr.id == p.id); }); 
                },
                child: PromptCard(
                  prompt: p, 
                  onTap: () => Navigator.pushNamed(context, AppRoutes.promptDetail, arguments: {'promptId': p.id, 'prompt': p})
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark_outline_rounded, size: 64, color: Colors.grey[200]),
            const SizedBox(height: 24),
            Text('NO SAVED PROMPTS', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Text('Collect your favorite AI prompts here.', textAlign: TextAlign.center, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.buttonGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ElevatedButton(
                  onPressed: () => _goToCategories(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('EXPLORE NOW', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showClearAllDialog(BuildContext context, PromptProvider prov) {
    final theme = Theme.of(context);
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: theme.cardColor,
      title: Text('CLEAR ALL?', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900)),
      content: Text('Delete all saved items?', style: theme.textTheme.bodyMedium),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL', style: TextStyle(fontWeight: FontWeight.w800))),
        TextButton(onPressed: () { prov.clearFavorites(); setState(() { _prompts = []; }); Navigator.pop(context); }, child: const Text('CLEAR ALL', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.w800))),
      ],
    ));
  }
}
