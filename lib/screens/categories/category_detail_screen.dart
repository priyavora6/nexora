import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../models/category_model.dart';
import '../../models/subcategory_model.dart';
import '../../providers/prompt_provider.dart';
import '../../services/firestore_service.dart';
import '../../utils/helpers.dart';
import '../../widgets/layout/bottom_nav_bar.dart';
import '../../widgets/layout/gradient_app_bar.dart';
import '../../widgets/example_gallery_widget.dart';
import '../../widgets/prompt_thumbnail_widget.dart';
import 'subcategory.dart'; 

class CategoryDetailScreen extends StatefulWidget {
  final String categoryId, categoryName, categoryColor;

  const CategoryDetailScreen({
    Key? key,
    required this.categoryId,
    required this.categoryName,
    required this.categoryColor,
  }) : super(key: key);

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.categories);
    }
  }

  Widget _buildHeroSection(Widget child) {
    return AnimatedBuilder(
      animation: _scrollController,
      builder: (context, _) {
        double scroll = 0;
        if (_scrollController.hasClients) {
          scroll = _scrollController.offset;
        }
        return Transform.translate(
          offset: Offset(0, scroll * 0.2),
          child: child,
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PromptProvider>(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Using the consistent brand color from Explore screen
    final brandColor = isDark ? AppColors.primary : const Color(0xFF2D265B);

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        _handleBack(context);
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: GradientAppBar(
          title: widget.categoryName.toUpperCase(),
          showBack: true,
          onBackPressed: () => _handleBack(context),
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 1),
        body: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TweenAnimationBuilder(
                duration: const Duration(milliseconds: 800),
                tween: Tween<double>(begin: 0, end: 1),
                curve: Curves.easeOutCubic,
                builder: (context, double value, child) {
                  return Transform.translate(
                    offset: Offset(0, -50 * (1 - value)),
                    child: Opacity(
                      opacity: value,
                      child: child,
                    ),
                  );
                },
                child: Column(
                  children: [
                    FutureBuilder<CategoryModel?>(
                      future: _getCategory(),
                      builder: (context, snap) {
                        if (snap.hasData && snap.data!.hasHeroExamples) {
                          return Column(
                            children: [
                              const SizedBox(height: 24),
                              _buildHeroSection(
                                ExampleGalleryWidget(
                                  exampleUrls: snap.data!.heroExampleUrls,
                                  height: 240,
                                  showIndicator: true,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'FEATURED VISUALS',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontSize: 10,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w900,
                                  color: theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),

                    FutureBuilder<CategoryModel?>(
                      future: _getCategory(),
                      builder: (context, snap) {
                        if (snap.hasData && snap.data!.description.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                            child: Text(
                              snap.data!.description,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                height: 1.6,
                                color: theme.textTheme.bodyMedium?.color,
                                fontSize: 15,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Text(
                  'SELECT A STYLE',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                    fontSize: 16,
                    color: brandColor, // Consistent brand color
                  ),
                ),
              ),

              StreamBuilder<List<SubcategoryModel>>(
                stream: prov.subcategoriesStream(widget.categoryId),
                builder: (context, snap) {
                  if (!snap.hasData) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(60),
                        child: CircularProgressIndicator(color: AppColors.primary),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
                    itemCount: snap.data!.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (_, i) {
                      final sub = snap.data![i];
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
                        child: _SubcategoryTile(
                          subcategory: sub,
                          brandColor: brandColor, // Pass brand color
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: const Duration(milliseconds: 400),
                                pageBuilder: (_, animation, __) => SubcategoryDetailScreen(
                                  categoryId: widget.categoryId,
                                  categoryName: widget.categoryName,
                                  subcategoryId: sub.id,
                                  subcategoryName: sub.name,
                                  categoryColor: widget.categoryColor,
                                ),
                                transitionsBuilder: (_, animation, __, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0, 0.08),
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
            ],
          ),
        ),
      ),
    );
  }

  Future<CategoryModel?> _getCategory() async {
    final categories = await FirestoreService().getCategories().first;
    return categories.firstWhere(
      (cat) => cat.id == widget.categoryId,
      orElse: () => CategoryModel(
        id: widget.categoryId,
        name: widget.categoryName,
        icon: '📁',
        color: widget.categoryColor,
      ),
    );
  }
}

class _SubcategoryTile extends StatefulWidget {
  final SubcategoryModel subcategory;
  final Color brandColor;
  final VoidCallback onTap;

  const _SubcategoryTile({
    required this.subcategory,
    required this.brandColor,
    required this.onTap,
  });

  @override
  State<_SubcategoryTile> createState() => _SubcategoryTileState();
}

class _SubcategoryTileState extends State<_SubcategoryTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double scale = 1;
  double elevation = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _startFloating();
  }

  void _startFloating() async {
    while (mounted) {
      await Future.delayed(const Duration(milliseconds: 1500));
      if (!mounted) return;
      setState(() => elevation = 6);
      await Future.delayed(const Duration(milliseconds: 1500));
      if (!mounted) return;
      setState(() => elevation = 0);
    }
  }

  void _onTapDown(_) {
    setState(() {
      scale = 0.96;
      elevation = 2;
    });
  }

  void _onTapUp(_) {
    setState(() {
      scale = 1;
      elevation = 6;
    });
    widget.onTap();
  }

  void _onCancel() {
    setState(() {
      scale = 1;
      elevation = 0;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sub = widget.subcategory;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onCancel,
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 120),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 80, 
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark ? theme.dividerColor.withOpacity(0.1) : widget.brandColor.withOpacity(0.15),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
                blurRadius: 15 + elevation,
                offset: Offset(0, 8 + elevation),
              ),
            ],
          ),
          child: Row(
            children: [
              if (sub.hasFeaturedExample)
                ClipRRect(
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(18.5)),
                  child: SizedBox(
                    width: 80,
                    height: double.infinity,
                    child: PromptThumbnailWidget(
                      imageUrl: sub.featuredExampleUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sub.name.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          letterSpacing: 0.5,
                          color: theme.textTheme.titleMedium?.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  transform: Matrix4.translationValues(elevation > 0 ? 4 : 0, 0, 0),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: isDark ? AppColors.primary : widget.brandColor.withOpacity(0.6),
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
