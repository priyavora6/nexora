import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';
import '../../models/category_model.dart';
import '../../utils/helpers.dart';

class CategoryTile extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const CategoryTile({
    Key? key,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the specific color for this category
    final color = Helpers.hexToColor(category.color);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white, // ✅ Clean white background
          borderRadius: BorderRadius.circular(20), // ✅ Softer rounded corners
          border: Border.all(
            color: color.withOpacity(0.2), // ✅ Soft tinted border
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.05), // ✅ Very subtle colored glow
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ─── ICON CONTAINER ───
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1), // ✅ Soft tinted background
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  category.icon,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ─── CATEGORY NAME ───
            Text(
              category.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.playfairDisplay( // ✅ Professional Serif Font
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary, // Deep Smoky
              ),
            ),

            const SizedBox(height: 6),

            // ─── PROMPT COUNT ───
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.lightInput, // Very soft rose background
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${category.promptCount} items',
                style: GoogleFonts.raleway( // ✅ Modern Sans Font
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary, // Smoky Rose
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}