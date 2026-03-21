import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../models/category_model.dart';
import '../../models/prompt_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/prompt_provider.dart';
import '../../widgets/cards/prompt_card.dart';
import '../../widgets/layout/bottom_nav_bar.dart';
import '../../widgets/layout/gradient_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  String _getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) return 'good morning';
    if (hour < 17) return 'good afternoon';
    return 'good evening';
  }

  String _getTagline() {
    var hour = DateTime.now().hour;
    if (hour < 12) return 'Ready to create something iconic?';
    if (hour < 17) return 'The perfect time for new visions.';
    return 'Reflecting on today\'s best ideas.';
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final promptProv = Provider.of<PromptProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const GradientAppBar(title: 'nexora'),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ─── 1. EXECUTIVE HEADER ───
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildOrbitAvatar(context, auth.userName),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${_getGreeting()}, ',
                                style: GoogleFonts.poppins(  // ✅ Changed
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textSecondary.withOpacity(0.6),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  auth.userName.toLowerCase(),
                                  style: GoogleFonts.poppins(  // ✅ Changed
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getTagline(),
                            style: GoogleFonts.poppins(  // ✅ Changed
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: AppColors.sage,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // ─── 2. LUXURY SEARCH ───
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildLuxurySearch(context),
              ),

              const SizedBox(height: 48),

              // ─── 3. COLLECTIONS ───
              _sectionHeader(context, 'Collections', AppRoutes.categories),
              const SizedBox(height: 20),
              _buildStoryCategories(promptProv),

              const SizedBox(height: 48),

              // ─── 4. DAILY DISCOVERY ───
              _sectionHeader(context, 'Daily Discovery', null),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: StreamBuilder<List<PromptModel>>(
                  stream: promptProv.trendingPromptsStream,
                  builder: (context, snap) {
                    if (!snap.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(color: AppColors.lightCoral),
                      );
                    }
                    final prompts = snap.data!;
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: prompts.length > 8 ? 8 : prompts.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, i) => PromptCard(
                        prompt: prompts[i],
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.promptDetail,
                          arguments: {'promptId': prompts[i].id},
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  // ─── WIDGET: AVATAR WITH ORBIT RING ───
  Widget _buildOrbitAvatar(BuildContext context, String name) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.lightCoral.withOpacity(0.15),
            width: 1,
          ),
        ),
        child: Container(
          height: 54,
          width: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.navGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.lightCoral.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : 'U',
              style: GoogleFonts.poppins(  // ✅ Changed
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─── WIDGET: LUXURY SEARCH ───
  Widget _buildLuxurySearch(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.search),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search_rounded,
              color: AppColors.lightCoral,
              size: 22,
            ),
            const SizedBox(width: 14),
            Text(
              'Search for inspiration...',
              style: GoogleFonts.poppins(  // ✅ Changed
                fontSize: 14,
                color: Colors.grey[400],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── WIDGET: CIRCLE COLLECTIONS ───
  Widget _buildStoryCategories(PromptProvider prov) {
    return StreamBuilder<List<CategoryModel>>(
      stream: prov.categoriesStream,
      builder: (context, snap) {
        if (!snap.hasData) return const SizedBox(height: 100);
        return SizedBox(
          height: 100,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: snap.data!.length,
            separatorBuilder: (_, __) => const SizedBox(width: 20),
            itemBuilder: (_, i) {
              final cat = snap.data![i];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.categoryDetail,
                  arguments: {
                    'categoryId': cat.id,
                    'categoryName': cat.name,
                    'categoryColor': cat.color,
                  },
                ),
                child: Column(
                  children: [
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey[100]!),
                      ),
                      child: Center(
                        child: Text(
                          cat.icon,
                          style: const TextStyle(fontSize: 26),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      cat.name.toLowerCase(),
                      style: GoogleFonts.poppins(  // ✅ Changed
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  // ─── WIDGET: SECTION HEADER ───
  Widget _sectionHeader(BuildContext context, String title, String? route) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(  // ✅ Changed
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              letterSpacing: -0.3,
            ),
          ),
          if (route != null)
            GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, route),
              child: Text(
                'see all',
                style: GoogleFonts.poppins(  // ✅ Changed
                  fontSize: 12,
                  color: AppColors.lightCoral,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}