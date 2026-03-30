// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import '../../config/app_colors.dart';
// import '../../models/prompt_model.dart';
// import '../../providers/prompt_provider.dart';
//
// class PromptCard extends StatefulWidget {
//   final PromptModel prompt;
//   final VoidCallback onTap;
//
//   const PromptCard({Key? key, required this.prompt, required this.onTap})
//       : super(key: key);
//
//   @override
//   State<PromptCard> createState() => _PromptCardState();
// }
//
// class _PromptCardState extends State<PromptCard>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnim;
//   late Animation<double> _glowAnim;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 140),
//     );
//     _scaleAnim = Tween<double>(begin: 1.0, end: 0.965).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOut),
//     );
//     _glowAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOut),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _onTapDown(_) {
//     HapticFeedback.lightImpact();
//     _controller.forward();
//   }
//
//   void _onTapUp(_) {
//     _controller.reverse();
//     widget.onTap();
//   }
//
//   void _onTapCancel() => _controller.reverse();
//
//   @override
//   Widget build(BuildContext context) {
//     final promptProv = Provider.of<PromptProvider>(context);
//     final isFav = promptProv.isFavorite(widget.prompt.id);
//     final hasImage =
//         widget.prompt.hasExample && widget.prompt.exampleImageUrl != null;
//
//     return GestureDetector(
//       onTapDown: _onTapDown,
//       onTapUp: _onTapUp,
//       onTapCancel: _onTapCancel,
//       child: AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) => Transform.scale(
//           scale: _scaleAnim.value,
//           child: child,
//         ),
//         child: Container(
//           margin: const EdgeInsets.only(bottom: 20),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(28),
//             // Subtle card shadow with brand color tint
//             boxShadow: [
//               BoxShadow(
//                 color: AppColors.royalBlue.withOpacity(0.10),
//                 blurRadius: 30,
//                 spreadRadius: -4,
//                 offset: const Offset(0, 12),
//               ),
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.06),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(28),
//             child: Stack(
//               children: [
//                 // ─── CARD BODY ───
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // ─── IMAGE WITH GRADIENT OVERLAY ───
//                     if (hasImage)
//                       _ImageSection(
//                         imageUrl: widget.prompt.exampleImageUrl!,
//                       ),
//
//                     // ─── CONTENT SECTION ───
//                     _ContentSection(
//                       prompt: widget.prompt,
//                       hasImage: hasImage,
//                     ),
//                   ],
//                 ),
//
//                 // ─── BOOKMARK BUTTON (absolute top-right) ───
//                 Positioned(
//                   top: hasImage ? 12 : 16,
//                   right: 16,
//                   child: _BookmarkButton(
//                     isFav: isFav,
//                     onTap: () {
//                       HapticFeedback.selectionClick();
//                       promptProv.toggleFavorite(widget.prompt.id);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────
// // IMAGE SECTION
// // ─────────────────────────────────────────────
// class _ImageSection extends StatelessWidget {
//   final String imageUrl;
//   const _ImageSection({required this.imageUrl});
//
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.55,
//       child: Stack(
//         fit: StackFit.expand,
//         children: [
//           // Image
//           Image.network(
//             imageUrl,
//             fit: BoxFit.cover,
//             errorBuilder: (_, __, ___) => Container(
//               color: const Color(0xFFF0F2F8),
//               child: const Center(
//                 child: Icon(
//                   Icons.image_outlined,
//                   size: 40,
//                   color: Color(0xFFBBC2D8),
//                 ),
//               ),
//             ),
//             loadingBuilder: (_, child, progress) {
//               if (progress == null) return child;
//               return Container(
//                 color: const Color(0xFFF0F2F8),
//                 child: Center(
//                   child: CircularProgressIndicator(
//                     value: progress.expectedTotalBytes != null
//                         ? progress.cumulativeBytesLoaded /
//                         progress.expectedTotalBytes!
//                         : null,
//                     strokeWidth: 2,
//                     color: AppColors.royalBlue.withOpacity(0.4),
//                   ),
//                 ),
//               );
//             },
//           ),
//
//           // Bottom gradient fade into card body
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             height: 80,
//             child: DecoratedBox(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.transparent,
//                     Theme.of(context).cardColor.withOpacity(0.85),
//                     Theme.of(context).cardColor,
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────
// // CONTENT SECTION
// // ─────────────────────────────────────────────
// class _ContentSection extends StatelessWidget {
//   final PromptModel prompt;
//   final bool hasImage;
//
//   const _ContentSection({required this.prompt, required this.hasImage});
//
//   @override
//   Widget build(BuildContext context) {
//     // If there's an image, overlap slightly upward for a layered feel
//     return Container(
//       color: Theme.of(context).cardColor,
//       padding: EdgeInsets.fromLTRB(
//         20,
//         hasImage ? 4 : 20,
//         // leave space for bookmark button on the right
//         56,
//         20,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ─── CATEGORY CHIP ───
//           if (prompt.categoryName.isNotEmpty) ...[
//             _CategoryChip(label: prompt.categoryName),
//             const SizedBox(height: 10),
//           ],
//
//           // ─── TITLE ───
//           Text(
//             prompt.title,
//             style: GoogleFonts.playfairDisplay(
//               fontSize: 21,
//               fontWeight: FontWeight.w700,
//               color: AppColors.textPrimary,
//               letterSpacing: -0.3,
//               height: 1.2,
//             ),
//           ),
//
//           const SizedBox(height: 6),
//
//           // ─── DESCRIPTION ───
//           Text(
//             prompt.description,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             style: GoogleFonts.dmSans(
//               fontSize: 13.5,
//               color: AppColors.textSecondary,
//               fontWeight: FontWeight.w400,
//               height: 1.5,
//             ),
//           ),
//
//           const SizedBox(height: 16),
//
//           // ─── BOTTOM ROW: use count / read time ───
//           Row(
//             children: [
//               _StatPill(
//                 icon: Icons.auto_awesome_rounded,
//                 label: 'Use prompt',
//                 color: AppColors.royalBlue,
//               ),
//               const Spacer(),
//               if (prompt.usageCount > 0)
//                 _MiniStat(
//                   icon: Icons.people_outline_rounded,
//                   label: _formatCount(prompt.usageCount),
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   String _formatCount(int n) {
//     if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
//     return n.toString();
//   }
// }
//
// // ─────────────────────────────────────────────
// // CATEGORY CHIP
// // ─────────────────────────────────────────────
// class _CategoryChip extends StatelessWidget {
//   final String label;
//   const _CategoryChip({required this.label});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: AppColors.royalBlue.withOpacity(0.09),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         label.toUpperCase(),
//         style: GoogleFonts.dmSans(
//           fontSize: 10.5,
//           fontWeight: FontWeight.w700,
//           color: AppColors.royalBlue,
//           letterSpacing: 0.8,
//         ),
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────
// // STAT PILL (CTA-style)
// // ─────────────────────────────────────────────
// class _StatPill extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Color color;
//
//   const _StatPill({
//     required this.icon,
//     required this.label,
//     required this.color,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [color, color.withOpacity(0.75)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: color.withOpacity(0.30),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 13, color: Colors.white),
//           const SizedBox(width: 5),
//           Text(
//             label,
//             style: GoogleFonts.dmSans(
//               fontSize: 12,
//               fontWeight: FontWeight.w700,
//               color: Colors.white,
//               letterSpacing: 0.2,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────
// // MINI STAT (usage count etc.)
// // ─────────────────────────────────────────────
// class _MiniStat extends StatelessWidget {
//   final IconData icon;
//   final String label;
//
//   const _MiniStat({required this.icon, required this.label});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(icon, size: 13, color: AppColors.textHint),
//         const SizedBox(width: 4),
//         Text(
//           label,
//           style: GoogleFonts.dmSans(
//             fontSize: 12,
//             color: AppColors.textHint,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // ─────────────────────────────────────────────
// // ANIMATED BOOKMARK BUTTON
// // ─────────────────────────────────────────────
// class _BookmarkButton extends StatefulWidget {
//   final bool isFav;
//   final VoidCallback onTap;
//
//   const _BookmarkButton({required this.isFav, required this.onTap});
//
//   @override
//   State<_BookmarkButton> createState() => _BookmarkButtonState();
// }
//
// class _BookmarkButtonState extends State<_BookmarkButton>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _ctrl;
//   late Animation<double> _scaleAnim;
//
//   @override
//   void initState() {
//     super.initState();
//     _ctrl = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 150),
//     );
//     _scaleAnim = Tween<double>(begin: 1.0, end: 1.25).animate(
//       CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack),
//     );
//   }
//
//   @override
//   void dispose() {
//     _ctrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   void didUpdateWidget(covariant _BookmarkButton oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.isFav != oldWidget.isFav && widget.isFav) {
//       _ctrl.forward().then((_) => _ctrl.reverse());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       child: ScaleTransition(
//         scale: _scaleAnim,
//         child: Container(
//           width: 40,
//           height: 40,
//           decoration: BoxDecoration(
//             color: widget.isFav ? Colors.white : Colors.black.withOpacity(0.2),
//             shape: BoxShape.circle,
//             boxShadow: [
//               if (widget.isFav)
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//             ],
//           ),
//           child: Icon(
//             widget.isFav ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
//             color: widget.isFav ? AppColors.royalBlue : Colors.white,
//             size: 22,
//           ),
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