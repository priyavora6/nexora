import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../models/prompt_model.dart';
import '../../models/subcategory_model.dart';
import '../../providers/prompt_provider.dart';
import '../../services/firestore_service.dart';
import '../../utils/helpers.dart';
import '../../widgets/cards/prompt_card.dart';
import '../../widgets/layout/bottom_nav_bar.dart';
import '../../widgets/layout/gradient_app_bar.dart';
import '../../widgets/prompt_thumbnail_widget.dart';
import '../prompts/prompt_detail_screen.dart';

class SubcategoryDetailScreen extends StatefulWidget {
  final String categoryId, categoryName, subcategoryId, subcategoryName, categoryColor;

  const SubcategoryDetailScreen({
    Key? key,
    required this.categoryId,
    required this.categoryName,
    required this.subcategoryId,
    required this.subcategoryName,
    required this.categoryColor,
  }) : super(key: key);

  @override
  State<SubcategoryDetailScreen> createState() => _SubcategoryDetailScreenState();
}

class _SubcategoryDetailScreenState extends State<SubcategoryDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnim = CurvedAnimation(
      parent: _fadeCtrl,
      curve: Curves.easeOut,
    );

    _fadeCtrl.forward();
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  void _handleBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PromptProvider>(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Using the same brand color logic as the Explore/Category tiles
    final brandColor = isDark ? AppColors.primary : const Color(0xFF2D265B);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: GradientAppBar(
        title: widget.subcategoryName.toUpperCase(),
        showBack: true,
        onBackPressed: () => _handleBack(context),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<SubcategoryModel?>(
                future: _getSubcategory(),
                builder: (context, snap) {
                  if (snap.hasData && snap.data!.hasFeaturedExample) {
                    return _buildFeaturedSection(context, snap.data!, theme);
                  }
                  return const SizedBox(height: 16);
                },
              ),

              FutureBuilder<SubcategoryModel?>(
                future: _getSubcategory(),
                builder: (context, snap) {
                  if (snap.hasData && snap.data!.description.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                      child: Text(
                        snap.data!.description,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.6,
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: Text(
                  'ALL PROMPTS',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: brandColor,
                  ),
                ),
              ),

              StreamBuilder<List<PromptModel>>(
                stream: prov.promptsBySubcategory(widget.categoryId, widget.subcategoryId),
                builder: (context, snap) {
                  if (!snap.hasData) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: CircularProgressIndicator(color: AppColors.primary),
                      ),
                    );
                  }

                  if (snap.data!.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          children: [
                            Icon(
                              Icons.inbox_outlined,
                              size: 64,
                              color: theme.colorScheme.onSurfaceVariant.withOpacity(0.3),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'NO PROMPTS FOUND',
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final sortedPrompts = List<PromptModel>.from(snap.data!);
                  sortedPrompts.sort((a, b) {
                    if (a.isFeatured && !b.isFeatured) return -1;
                    if (!a.isFeatured && b.isFeatured) return 1;
                    return 0;
                  });

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                    itemCount: sortedPrompts.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, i) {
                      final prompt = sortedPrompts[i];
                      
                      return TweenAnimationBuilder(
                        duration: Duration(milliseconds: 400 + (i * 70)),
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
                        child: _AnimatedPromptCard(
                          prompt: prompt,
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: const Duration(milliseconds: 400),
                                pageBuilder: (_, animation, __) => PromptDetailScreen(
                                  promptId: prompt.id,
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

  Widget _buildFeaturedSection(BuildContext context, SubcategoryModel subcategory, ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final brandColor = isDark ? AppColors.primary : const Color(0xFF2D265B);
    
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 40 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: brandColor.withOpacity(0.2), width: 2),
          boxShadow: [
            BoxShadow(
              color: brandColor.withOpacity(isDark ? 0.2 : 0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: brandColor.withOpacity(0.1),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              ),
              child: Row(
                children: [
                  Icon(Icons.auto_awesome, size: 16, color: brandColor),
                  const SizedBox(width: 8),
                  Text(
                    'FEATURED EXAMPLE',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: brandColor,
                      letterSpacing: 0.5,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(18)),
              child: PromptThumbnailWidget(
                imageUrl: subcategory.featuredExampleUrl,
                height: 220,
                fit: BoxFit.cover,
                showPlayIcon: false,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'THIS IS WHAT YOU CAN CREATE ✨',
                style: TextStyle(
                  fontSize: 10,
                  color: brandColor.withOpacity(0.7),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<SubcategoryModel?> _getSubcategory() async {
    try {
      final subcategories = await FirestoreService()
          .getSubcategoriesList(widget.categoryId);

      return subcategories.firstWhere(
            (sub) => sub.id == widget.subcategoryId,
        orElse: () => SubcategoryModel(
          id: widget.subcategoryId,
          name: widget.subcategoryName,
          icon: '📁',
          order: 0,
          promptCount: 0,
        ),
      );
    } catch (e) {
      debugPrint('Error fetching subcategory: $e');
      return null;
    }
  }
}

class _AnimatedPromptCard extends StatefulWidget {
  final PromptModel prompt;
  final VoidCallback onTap;

  const _AnimatedPromptCard({
    required this.prompt,
    required this.onTap,
  });

  @override
  State<_AnimatedPromptCard> createState() => _AnimatedPromptCardState();
}

class _AnimatedPromptCardState extends State<_AnimatedPromptCard> {
  double scale = 1;
  double elevation = 0;

  void _tapDown(TapDownDetails details) {
    setState(() {
      scale = 0.96;
      elevation = 4;
    });
  }

  void _tapUp(TapUpDetails details) {
    setState(() {
      scale = 1;
      elevation = 8;
    });
    widget.onTap();
  }

  void _cancel() {
    setState(() {
      scale = 1;
      elevation = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTapCancel: _cancel,
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 120),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12 + elevation,
                offset: Offset(0, 6 + elevation),
              ),
            ],
          ),
          child: PromptCard(
            prompt: widget.prompt,
            onTap: widget.onTap,
          ),
        ),
      ),
    );
  }
}
