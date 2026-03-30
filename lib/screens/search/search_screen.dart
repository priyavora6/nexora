import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../models/prompt_model.dart';
import '../../models/category_model.dart';
import '../../providers/prompt_provider.dart';
import '../../services/firestore_service.dart';
import '../../widgets/cards/prompt_card.dart';
import '../../widgets/layout/bottom_nav_bar.dart';
import '../../widgets/layout/gradient_app_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _ctrl = TextEditingController();
  List<PromptModel> _results = [];
  bool _loading = false;
  bool _searched = false;
  String? _selectedCategoryId;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _handleSearch(String query) async {
    if (query.trim().isEmpty && _selectedCategoryId == null) return;

    setState(() {
      _loading = true;
      _searched = true;
    });

    final prov = Provider.of<PromptProvider>(context, listen: false);
    if (query.trim().isNotEmpty) {
      await prov.addRecentSearch(query.trim());
    }

    _results = await FirestoreService().searchPromptsWithFilters(
      query: query.trim(),
      categoryId: _selectedCategoryId,
    );

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PromptProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const GradientAppBar(title: 'SEARCH', showBack: true),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── 1. PROPER SEARCH BAR ───
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
              controller: _ctrl,
              onSubmitted: _handleSearch,
              style: GoogleFonts.inter(fontWeight: FontWeight.w500, color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'SEARCH FOR PROMPTS...',
                prefixIcon: const Icon(Icons.search_rounded, color: AppColors.royalBlue),
                suffixIcon: _ctrl.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () {
                          _ctrl.clear();
                          setState(() {
                            _searched = false;
                            _results.clear();
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.lightInput,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ─── 2. DYNAMIC CATEGORY PILLS ───
          StreamBuilder<List<CategoryModel>>(
            stream: prov.categoriesStream,
            builder: (context, snap) {
              if (!snap.hasData) return const SizedBox(height: 40);
              final categories = snap.data!;
              
              return SizedBox(
                height: 40,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length + 1,
                  itemBuilder: (context, index) {
                    final isAll = index == 0;
                    final cat = isAll ? null : categories[index - 1];
                    final label = isAll ? 'ALL' : cat!.name.toUpperCase();
                    final isSelected = isAll ? _selectedCategoryId == null : _selectedCategoryId == cat!.id;

                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ChoiceChip(
                        label: Text(label),
                        selected: isSelected,
                        onSelected: (val) {
                          setState(() => _selectedCategoryId = isAll ? null : cat!.id);
                          _handleSearch(_ctrl.text);
                        },
                        selectedColor: AppColors.royalBlue,
                        backgroundColor: AppColors.lightInput,
                        labelStyle: GoogleFonts.inter(
                            color: isSelected ? Colors.white : AppColors.textSecondary,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        side: BorderSide.none,
                        showCheckmark: false,
                      ),
                    );
                  },
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          // ─── 3. RESULTS AREA ───
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator(color: AppColors.royalBlue))
                : !_searched
                ? _buildRecentSearches(prov, theme)
                : _results.isEmpty
                ? _buildEmptyState(theme)
                : _buildResultsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSearches(PromptProvider prov, ThemeData theme) {
    if (prov.recentSearches.isEmpty) {
      return Center(child: Text('SEARCH FOR INSPIRATION...', style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w800, letterSpacing: 1, color: AppColors.textHint)));
    }
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        Text('RECENT SEARCHES', style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w900, color: AppColors.royalBlue, letterSpacing: 1)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: prov.recentSearches.map((s) => ActionChip(
            label: Text(s.toUpperCase()),
            onPressed: () { _ctrl.text = s; _handleSearch(s); },
            labelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
            backgroundColor: AppColors.lightInput,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            side: BorderSide.none,
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildResultsList() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      itemCount: _results.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, i) => PromptCard(
        prompt: _results[i],
        onTap: () => Navigator.pushNamed(context, AppRoutes.promptDetail, arguments: {'promptId': _results[i].id}),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 60, color: AppColors.textHint),
          const SizedBox(height: 16),
          Text('NO RESULTS FOUND', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900, letterSpacing: 1, color: AppColors.textHint)),
        ],
      ),
    );
  }
}
