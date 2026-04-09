import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/category_model.dart';
import '../../config/app_colors.dart';

class CategoryTile extends StatefulWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const CategoryTile({
    Key? key,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scale = Tween(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) => _controller.forward();
  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }
  void _onTapCancel() => _controller.reverse();

  IconData _getCategoryIcon(String name) {
    final n = name.toLowerCase();
    
    // People & Relationships
    if (n.contains('portrait') || n.contains('headshot')) return Icons.person_rounded;
    if (n.contains('couple') || n.contains('romance')) return Icons.favorite_rounded;
    if (n.contains('family') || n.contains('kid')) return Icons.groups_rounded;
    
    // Lifestyle & Events
    if (n.contains('festival') || n.contains('occasion')) return Icons.celebration_rounded;
    if (n.contains('wedding')) return Icons.favorite_border_rounded; 
    if (n.contains('food') || n.contains('restaurant')) return Icons.restaurant_rounded;
    if (n.contains('fashion') || n.contains('lifestyle')) return Icons.checkroom_rounded;
    
    // Professional & Tech
    if (n.contains('business') || n.contains('marketing')) return Icons.business_center_rounded;
    if (n.contains('product') || n.contains('e-commerce')) return Icons.shopping_bag_rounded;
    if (n.contains('ai tools') || n.contains('platform')) return Icons.psychology_rounded;
    if (n.contains('gaming') || n.contains('esports')) return Icons.sports_esports_rounded;
    if (n.contains('photo enhancement')) return Icons.auto_fix_high_rounded;
    if (n.contains('social media')) return Icons.public_rounded;
    
    // Creative & Environment
    if (n.contains('art') || n.contains('style')) return Icons.palette_rounded;
    if (n.contains('nature') || n.contains('landscape')) return Icons.landscape_rounded;
    if (n.contains('animal') || n.contains('pet')) return Icons.pets_rounded;
    if (n.contains('architecture') || n.contains('interior')) return Icons.home_work_rounded;
    if (n.contains('vehicle') || n.contains('travel')) return Icons.directions_car_rounded;
    
    return Icons.category_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: theme.dividerColor.withOpacity(isDark ? 0.05 : 0.1),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon Area
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(isDark ? 0.15 : 0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getCategoryIcon(widget.category.name),
                  size: 32,
                  color: isDark ? AppColors.primary : const Color(0xFF2D265B),
                ),
              ),
              const SizedBox(height: 12),
              // Text Area
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  widget.category.name.toUpperCase(),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                    letterSpacing: 0.2,
                    color: theme.textTheme.titleMedium?.color,
                    height: 1.2,
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
