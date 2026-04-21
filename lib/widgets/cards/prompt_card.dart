import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
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
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final promptProv = Provider.of<PromptProvider>(context);
    final isFav = promptProv.isFavorite(widget.prompt.id);
    final hasImage = widget.prompt.hasExample && widget.prompt.exampleImageUrl != null;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) => Transform.scale(
          scale: _scaleAnim.value,
          child: child,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          height: 170,
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: theme.dividerColor.withOpacity(isDark ? 0.1 : 0.6),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: AppColors.primary.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Row(
              children: [
                // ── IMAGE SECTION ──
                if (hasImage)
                  Stack(
                    children: [
                      SizedBox(
                        width: 120,
                        height: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: widget.prompt.exampleImageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                            highlightColor: isDark ? Colors.grey[700]! : Colors.grey[50]!,
                            child: Container(color: theme.cardColor),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: theme.colorScheme.surfaceContainerHighest,
                            child: Icon(Icons.broken_image_outlined, color: AppColors.primary.withOpacity(0.3)),
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.black.withOpacity(isDark ? 0.3 : 0.1), Colors.transparent],
                          ),
                        ),
                      ),
                    ],
                  ),

                // ── CONTENT SECTION ──
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Row: Badge & Bookmark
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(child: _CategoryBadge(label: widget.prompt.categoryName, color: AppColors.primary)),
                            _BookmarkBtn(
                              isFav: isFav,
                              activeColor: AppColors.primary,
                              onTap: () {
                                HapticFeedback.mediumImpact();
                                promptProv.toggleFavorite(widget.prompt.id);
                              },
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Title
                        Text(
                          widget.prompt.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: theme.textTheme.titleLarge?.color,
                          ),
                        ),
                        
                        const SizedBox(height: 4),
                        
                        // Description
                        Text(
                          widget.prompt.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.dmSans(
                            fontSize: 12,
                            color: theme.textTheme.bodyMedium?.color,
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                          ),
                        ),
                        
                        const Spacer(),
                        
                        // Bottom Row: Button & Stats
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const _GradientUseButton(),

                            if (widget.prompt.usageCount > 0)
                              _UsageStat(
                                count: widget.prompt.usageCount,
                                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6) ?? Colors.grey,
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
}

class _GradientUseButton extends StatelessWidget {
  const _GradientUseButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_awesome_rounded, size: 12, color: Colors.white),
          const SizedBox(width: 5),
          Text(
            "Use",
            style: GoogleFonts.dmSans(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          )
        ],
      ),
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _CategoryBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.12)),
      ),
      child: Text(
        label.toUpperCase(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.inter(
          fontSize: 8.5,
          fontWeight: FontWeight.w900,
          color: color,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class _BookmarkBtn extends StatelessWidget {
  final bool isFav;
  final Color activeColor;
  final VoidCallback onTap;

  const _BookmarkBtn({required this.isFav, required this.onTap, required this.activeColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isFav ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
        size: 20,
        color: isFav ? activeColor : theme.iconTheme.color?.withOpacity(0.4),
      ),
    );
  }
}

class _UsageStat extends StatelessWidget {
  final int count;
  final Color color;
  const _UsageStat({required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    String fmt = count >= 1000 ? '${(count / 1000).toStringAsFixed(1)}k' : count.toString();
    return Row(
      children: [
        Icon(Icons.remove_red_eye_outlined, size: 13, color: color),
        const SizedBox(width: 3),
        Text(
          fmt,
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }
}
