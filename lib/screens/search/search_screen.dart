import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../prompts/prompt_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _ctrl = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<PromptModel> _results = [];
  bool _loading = false;
  String? _selectedCategoryId;

  final Color brandPurple = AppColors.violet;

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(() {
      if (mounted) setState(() {}); 
    });
    // Load initial prompts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchDefaultPrompts();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleBack() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
    }
  }

  Future<void> _fetchDefaultPrompts() async {
    setState(() => _loading = true);
    
    final service = FirestoreService();
    List<PromptModel> prompts;
    
    if (_selectedCategoryId == null) {
      // Fetch prompts from everywhere and shuffle randomly
      final stream = service.getTrendingPrompts(limit: 60);
      prompts = await stream.first;
      prompts.shuffle();
      if (prompts.length > 20) prompts = prompts.sublist(0, 20);
    } else {
      // Fetch prompts for specific category
      final stream = service.getPromptsByCategory(_selectedCategoryId!);
      prompts = await stream.first;
      prompts.shuffle();
      if (prompts.length > 20) prompts = prompts.sublist(0, 20);
    }

    if (mounted) {
      setState(() {
        _results = prompts;
        _loading = false;
      });
    }
  }

  Future<void> _handleSearch(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      _fetchDefaultPrompts();
      return;
    }

    _focusNode.unfocus();
    setState(() => _loading = true);

    final prov = Provider.of<PromptProvider>(context, listen: false);
    await prov.addRecentSearch(trimmed);

    final results = await FirestoreService().searchPromptsWithFilters(
      query: trimmed,
      categoryId: _selectedCategoryId,
    );

    if (mounted) {
      setState(() {
        _results = results;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PromptProvider>(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _handleBack();
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: GradientAppBar(
          title: 'SEARCH', 
          showBack: true,
          onBackPressed: _handleBack,
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 2),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Input
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: brandPurple.withOpacity(isDark ? 0.2 : 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _ctrl,
                  focusNode: _focusNode,
                  onSubmitted: _handleSearch,
                  textInputAction: TextInputAction.search,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search for inspiration...',
                    hintStyle: GoogleFonts.inter(
                      color: theme.hintColor,
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: Icon(Icons.search_rounded, color: brandPurple, size: 24),
                    suffixIcon: _ctrl.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.close_rounded, size: 20, color: theme.hintColor),
                            onPressed: () {
                              _ctrl.clear();
                              _fetchDefaultPrompts();
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: theme.cardColor,
                    contentPadding: const EdgeInsets.symmetric(vertical: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: brandPurple.withOpacity(0.1), width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: brandPurple.withOpacity(0.1), width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: brandPurple, width: 2.0),
                    ),
                  ),
                ),
              ),
            ),
      
            const SizedBox(height: 16),

            // Recent Searches Chips
            if (prov.recentSearches.isNotEmpty) 
              _buildRecentSearchesChips(prov, theme),

            const SizedBox(height: 12),
      
            // Categories
            StreamBuilder<List<CategoryModel>>(
              stream: prov.categoriesStream,
              builder: (context, snap) {
                if (!snap.hasData) return const SizedBox(height: 44);
                final categories = snap.data!;
      
                return SizedBox(
                  height: 44,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: categories.length + 1,
                    itemBuilder: (context, index) {
                      final isAll = index == 0;
                      final cat = isAll ? null : categories[index - 1];
                      final label = isAll ? 'ALL' : cat!.name.toUpperCase();
                      final isSelected = isAll ? _selectedCategoryId == null : _selectedCategoryId == cat!.id;
      
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            if (isSelected) return;
                            HapticFeedback.lightImpact();
                            setState(() {
                              _selectedCategoryId = isAll ? null : cat!.id;
                            });
                            if (_ctrl.text.isEmpty) {
                              _fetchDefaultPrompts();
                            } else {
                              _handleSearch(_ctrl.text);
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? brandPurple : theme.cardColor,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: isSelected ? brandPurple : brandPurple.withOpacity(0.15),
                                width: 1.5,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: brandPurple.withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      )
                                    ]
                                  : [],
                            ),
                            child: Center(
                              child: Text(
                                label,
                                style: GoogleFonts.inter(
                                  color: isSelected ? Colors.white : theme.textTheme.bodyMedium?.color,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      
            const SizedBox(height: 20),
      
            // Results or Loading or Empty
            Expanded(
              child: _loading
                  ? Center(child: CircularProgressIndicator(color: brandPurple))
                  : _results.isEmpty
                      ? _buildEmptyState(theme)
                      : _buildResultsList(theme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearchesChips(PromptProvider prov, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RECENT',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: brandPurple.withOpacity(0.6),
                  letterSpacing: 1.2,
                ),
              ),
              GestureDetector(
                onTap: () => prov.clearSearches(),
                child: Text(
                  'CLEAR',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Colors.redAccent.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 32,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: prov.recentSearches.length,
            itemBuilder: (context, index) {
              final search = prov.recentSearches[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () {
                    _ctrl.text = search;
                    _handleSearch(search);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          Icon(Icons.history_rounded, size: 14, color: theme.hintColor),
                          const SizedBox(width: 6),
                          Text(
                            search,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: theme.textTheme.bodyMedium?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildResultsList(ThemeData theme) {
    // Hide title header if it's the default "ALL" view
    final bool hideHeader = _ctrl.text.isEmpty && _selectedCategoryId == null;
    
    final title = _ctrl.text.isEmpty 
        ? 'RECOMMENDED'
        : 'SEARCH RESULTS';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!hideHeader)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: brandPurple,
                letterSpacing: 1.2,
              ),
            ),
          ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            physics: const BouncingScrollPhysics(),
            itemCount: _results.length,
            itemBuilder: (_, i) => PromptCard(
              prompt: _results[i],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PromptDetailScreen(
                      promptId: _results[i].id,
                      prompt: _results[i],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sentiment_dissatisfied_rounded, size: 80, color: brandPurple.withOpacity(0.1)),
          const SizedBox(height: 16),
          Text(
            'NO RESULTS FOUND',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
              color: theme.hintColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching for something else',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: theme.hintColor.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
