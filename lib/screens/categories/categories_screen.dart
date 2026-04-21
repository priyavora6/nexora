import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../models/category_model.dart';
import '../../providers/prompt_provider.dart';
import '../../widgets/cards/category_tile.dart';
import '../../widgets/layout/bottom_nav_bar.dart';
import '../../widgets/layout/gradient_app_bar.dart';
import 'category_detail_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  void _goToHome(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
            (route) => false,
      );
    }
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
          title: 'EXPLORE',
          showBack: true,
          onBackPressed: () => _goToHome(context),
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 1),
        body: StreamBuilder<List<CategoryModel>>(
          stream: prov.categoriesStream,
          builder: (context, snap) {
            if (!snap.hasData) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (snap.data!.isEmpty) {
              return Center(
                child: Text(
                  'No Categories Yet',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
                  ),
                ),
              );
            }

            final categories = snap.data!;

            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.82,
              ),
              itemCount: categories.length,
              itemBuilder: (_, i) {
                final cat = categories[i];
                
                // ─── STAGGERED ENTRANCE ANIMATION ───
                return TweenAnimationBuilder(
                  duration: Duration(milliseconds: 400 + (i * 80)),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return Transform.translate(
                      offset: Offset(0, 30 * (1 - value)),
                      child: Opacity(
                        opacity: value,
                        child: child,
                      ),
                    );
                  },
                  child: CategoryTile(
                    category: cat,
                    onTap: () {
                      // ─── CUSTOM PAGE TRANSITION ───
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 400),
                          pageBuilder: (_, animation, __) => CategoryDetailScreen(
                            categoryId: cat.id,
                            categoryName: cat.name,
                            categoryColor: cat.color,
                          ),
                          transitionsBuilder: (_, animation, __, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 0.1),
                                  end: Offset.zero,
                                ).animate(CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOutCubic,
                                )),
                                child: child,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
