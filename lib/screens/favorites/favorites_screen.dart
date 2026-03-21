import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // ✅ Standardizing on Poppins
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../models/prompt_model.dart';
import '../../providers/prompt_provider.dart';
import '../../services/firestore_service.dart';
import '../../widgets/cards/prompt_card.dart';
import '../../widgets/layout/bottom_nav_bar.dart';
import '../../widgets/layout/gradient_app_bar.dart';

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

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PromptProvider>(context);
    final favIds = prov.favoriteIds;

    return WillPopScope(
      onWillPop: () async {
        _goToHome(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: GradientAppBar(
          title: 'SAVED',
          showBack: true,
          onBackPressed: () => _goToHome(context),
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 3),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator(color: AppColors.lightCoral))
            : favIds.isEmpty || (_prompts != null && _prompts!.isEmpty)
            ? _buildEmptyState()
            : _buildSavedList(prov),
      ),
    );
  }

  // ─── SAVED LIST (Poppins Style) ───
  Widget _buildSavedList(PromptProvider prov) {
    final prompts = _prompts ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${prompts.length} saved items',
                      style: GoogleFonts.poppins( // ✅ Changed to Poppins
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      'your curated inspiration collection',
                      style: GoogleFonts.poppins( // ✅ Changed to Poppins
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _showClearAllDialog(context, prov),
                child: Text(
                  'clear all',
                  style: GoogleFonts.poppins( // ✅ Changed to Poppins
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.lightCoral,
                  ),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
            physics: const BouncingScrollPhysics(),
            itemCount: prompts.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (_, i) {
              final p = prompts[i];
              return Dismissible(
                key: Key(p.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 25),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(Icons.bookmark_remove_rounded, color: AppColors.error, size: 28),
                ),
                confirmDismiss: (direction) async => await _showRemoveDialog(context, p.title),
                onDismissed: (_) {
                  prov.toggleFavorite(p.id);
                  setState(() => _prompts!.removeAt(i));
                },
                child: PromptCard(
                  prompt: p,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.promptDetail, arguments: {'promptId': p.id}),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ─── EMPTY STATE (Poppins Style) ───
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.bookmark_outline_rounded, size: 64, color: AppColors.sage),
            const SizedBox(height: 24),
            Text(
              'No saved prompts',
              style: GoogleFonts.poppins( // ✅ Changed to Poppins
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Collect your favorite AI prompts here to access them anytime.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins( // ✅ Changed to Poppins
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => _goToHome(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightCoral,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                'Explore Now',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white), // ✅ Poppins
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── DIALOGS (Poppins Style) ───
  Future<bool?> _showRemoveDialog(BuildContext context, String title) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text('Remove Prompt?', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        content: Text('Do you want to remove "$title" from your collection?', style: GoogleFonts.poppins()),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.grey))),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Remove', style: GoogleFonts.poppins(color: AppColors.error, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  void _showClearAllDialog(BuildContext context, PromptProvider prov) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text('Clear All?', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        content: Text('This will permanently delete all saved items.', style: GoogleFonts.poppins()),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.grey))),
          TextButton(
            onPressed: () {
              prov.clearFavorites();
              setState(() => _prompts = []);
              Navigator.pop(context);
            },
            child: Text('Clear All', style: GoogleFonts.poppins(color: AppColors.error, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}