// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../config/app_colors.dart';
// import '../../models/category_model.dart';
// import '../../utils/helpers.dart';
//
// class CategoryTile extends StatelessWidget {
//   final CategoryModel category;
//   final VoidCallback onTap;
//
//   const CategoryTile({
//     Key? key,
//     required this.category,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Get the specific color for this category
//     final color = Helpers.hexToColor(category.color);
//
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white, // ✅ Clean white background
//           borderRadius: BorderRadius.circular(20), // ✅ Softer rounded corners
//           border: Border.all(
//             color: color.withOpacity(0.2), // ✅ Soft tinted border
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: color.withOpacity(0.05), // ✅ Very subtle colored glow
//               blurRadius: 15,
//               offset: const Offset(0, 8),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // ─── ICON CONTAINER ───
//             Container(
//               width: 55,
//               height: 55,
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.1), // ✅ Soft tinted background
//                 shape: BoxShape.circle,
//               ),
//               child: Center(
//                 child: Text(
//                   category.icon,
//                   style: const TextStyle(fontSize: 28),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             // ─── CATEGORY NAME ───
//             Text(
//               category.name,
//               textAlign: TextAlign.center,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: GoogleFonts.playfairDisplay( // ✅ Professional Serif Font
//                 fontSize: 13,
//                 fontWeight: FontWeight.w800,
//                 color: AppColors.textPrimary, // Deep Smoky
//               ),
//             ),
//
//             const SizedBox(height: 6),
//
//             // ─── PROMPT COUNT ───
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//               decoration: BoxDecoration(
//                 color: AppColors.lightInput, // Very soft rose background
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 '${category.promptCount} items',
//                 style: GoogleFonts.raleway( // ✅ Modern Sans Font
//                   fontSize: 10,
//                   fontWeight: FontWeight.w700,
//                   color: AppColors.textSecondary, // Smoky Rose
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






















import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../models/prompt_model.dart';
import '../../providers/prompt_provider.dart';

class PromptCard extends StatefulWidget {
  final PromptModel prompt;
  final VoidCallback onTap;

  const PromptCard({Key? key, required this.prompt, required this.onTap})
      : super(key: key);

  @override
  State<PromptCard> createState() => _PromptCardState();
}

class _PromptCardState extends State<PromptCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );

    _scaleAnim = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  void _onTapDown(_) {
    HapticFeedback.lightImpact();
    _controller.forward();
  }

  void _onTapUp(_) {
    _controller.reverse();
    widget.onTap();
  }

  void _onTapCancel() => _controller.reverse();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final promptProv = Provider.of<PromptProvider>(context);
    final isFav = promptProv.isFavorite(widget.prompt.id);
    final hasImage =
        widget.prompt.hasExample && widget.prompt.exampleImageUrl != null;

    final color = AppColors.violet;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) => Transform.scale(
          scale: _scaleAnim.value,
          child: child,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),

          decoration: BoxDecoration(
            color: color.withOpacity(0.06),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: color.withOpacity(0.25),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.12),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 🔹 IMAGE
                if (hasImage)
                  SizedBox(
                    width: 100,
                    child: Image.network(
                      widget.prompt.exampleImageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),

                // 🔹 CONTENT
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // ✅ FIX
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TOP ROW
                        Row(
                          children: [
                            if (widget.prompt.categoryName.isNotEmpty)
                              Flexible(
                                child: _CategoryChip(
                                    label: widget.prompt.categoryName),
                              ),
                            const Spacer(),
                            _BookmarkButton(
                              isFav: isFav,
                              onTap: () {
                                HapticFeedback.selectionClick();
                                promptProv
                                    .toggleFavorite(widget.prompt.id);
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        // TITLE
                        Text(
                          widget.prompt.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: color,
                          ),
                        ),

                        const SizedBox(height: 3),

                        // DESCRIPTION
                        Text(
                          widget.prompt.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.dmSans(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // BOTTOM ROW
                        Row(
                          children: [
                            _UseButton(color: color),
                            const Spacer(),
                            if (widget.prompt.usageCount > 0)
                              _MiniStat(
                                icon: Icons.people_outline,
                                label:
                                _formatCount(widget.prompt.usageCount),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatCount(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return n.toString();
  }
}

// CATEGORY CHIP
class _CategoryChip extends StatelessWidget {
  final String label;
  const _CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.violet;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label.toUpperCase(),
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.dmSans(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

// USE BUTTON
class _UseButton extends StatelessWidget {
  final Color color;
  const _UseButton({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.35),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, size: 13, color: Colors.white),
          const SizedBox(width: 5),
          Text(
            "Use",
            style: GoogleFonts.dmSans(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// MINI STAT
class _MiniStat extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MiniStat({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 12, color: AppColors.textHint),
        const SizedBox(width: 3),
        Text(
          label,
          style: GoogleFonts.dmSans(
            fontSize: 11,
            color: AppColors.textHint,
          ),
        ),
      ],
    );
  }
}

// BOOKMARK BUTTON
class _BookmarkButton extends StatelessWidget {
  final bool isFav;
  final VoidCallback onTap;

  const _BookmarkButton({required this.isFav, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.violet;

    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isFav ? Icons.bookmark : Icons.bookmark_border,
        size: 20,
        color: isFav ? color : Colors.grey,
      ),
    );
  }
}