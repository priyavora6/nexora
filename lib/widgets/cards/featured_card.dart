import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';
import '../../models/prompt_model.dart';

class FeaturedCard extends StatelessWidget {
  final PromptModel prompt;
  final VoidCallback onTap;

  const FeaturedCard({
    Key? key,
    required this.prompt,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          // ✅ Matches the Header and Bottom Nav Gradient
          gradient: AppColors.navGradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.royalBlue.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── TOP ROW: BADGE & ICON ───
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.auto_awesome, size: 12, color: Colors.white),
                      const SizedBox(width: 6),
                      Text(
                        'FEATURED',
                        style: GoogleFonts.raleway(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ─── TITLE ───
            Text(
              prompt.title,
              style: GoogleFonts.playfairDisplay( // ✅ Professional Serif Font
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1.2,
              ),
            ),

            const SizedBox(height: 10),

            // ─── DESCRIPTION PREVIEW ───
            Text(
              prompt.text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.raleway( // ✅ Modern Sans Font
                fontSize: 13,
                color: Colors.white.withOpacity(0.9),
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
