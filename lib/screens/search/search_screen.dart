import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../models/prompt_model.dart';
import '../../providers/prompt_provider.dart';
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

  Future<void> _search(String query) async {
    if (query.trim().isEmpty) return;
    setState(() {
      _loading = true;
      _searched = true;
    });

    final prov = Provider.of<PromptProvider>(context, listen: false);
    await prov.addRecentSearch(query.trim());
    _results = await prov.searchPrompts(query.trim());

    setState(() => _loading = false);
  }

  // ✅ Go to Home function
  void _goToHome() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
          (route) => false,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PromptProvider>(context);

    // ✅ WillPopScope handles phone back button
    return WillPopScope(
      onWillPop: () async {
        _goToHome();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,

        // ✅ Gradient Header with Back Arrow
        appBar: GradientAppBar(
          title: 'SEARCH',
          showBack: true, // ✅ Shows back arrow
          onBackPressed: _goToHome, // ✅ Goes to Home
        ),

        // ✅ Bottom Navigation
        bottomNavigationBar: const BottomNavBar(currentIndex: 2),

        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Search Field ───
              TextField(
                controller: _ctrl,
                autofocus: true,
                onSubmitted: _search,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  hintText: 'What are you looking for?',
                  hintStyle: GoogleFonts.poppins(color: AppColors.textHint),
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.sage),
                  fillColor: AppColors.lightInput,
                  suffixIcon: _ctrl.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear_rounded, color: AppColors.textHint),
                    onPressed: () {
                      _ctrl.clear();
                      setState(() {
                        _results.clear();
                        _searched = false;
                      });
                    },
                  )
                      : null,
                ),
              ),

              const SizedBox(height: 24),

              // ─── Recent Searches Section ───
              if (!_searched && prov.recentSearches.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Searches',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => prov.clearSearches(),
                      child: Text(
                        'Clear all',
                        style: GoogleFonts.poppins(
                          color: AppColors.lightCoral,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: prov.recentSearches
                      .map((s) => GestureDetector(
                    onTap: () {
                      _ctrl.text = s;
                      _search(s);
                    },
                    child: Chip(
                      label: Text(s),
                      backgroundColor: AppColors.lightInput,
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                      side: BorderSide(color: AppColors.border.withOpacity(0.3)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ))
                      .toList(),
                ),
              ],

              const SizedBox(height: 10),

              // ─── Results Area ───
              if (_loading)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.lightCoral,
                    ),
                  ),
                )
              else if (_searched && _results.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search_off_rounded,
                          size: 64,
                          color: AppColors.sage,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'No matching prompts',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try using different keywords',
                          style: GoogleFonts.poppins(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: _results.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (_, i) => PromptCard(
                      prompt: _results[i],
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.promptDetail,
                        arguments: {'promptId': _results[i].id},
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
