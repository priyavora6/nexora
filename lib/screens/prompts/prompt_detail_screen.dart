import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../config/app_colors.dart';
import '../../models/prompt_model.dart';
import '../../providers/prompt_provider.dart';
import '../../services/firestore_service.dart';
import '../../widgets/common/webview_screen.dart';

class PromptDetailScreen extends StatefulWidget {
  final String promptId;
  final PromptModel? prompt;

  const PromptDetailScreen({
    Key? key, 
    required this.promptId,
    this.prompt,
  }) : super(key: key);

  @override
  State<PromptDetailScreen> createState() => _PromptDetailScreenState();
}

class _PromptDetailScreenState extends State<PromptDetailScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollCtrl = ScrollController();
  
  Future<PromptModel?>? _promptFuture;
  int _localUsageCount = 0; 

  @override
  void initState() {
    super.initState();
    if (widget.prompt != null) {
      _promptFuture = Future.value(widget.prompt);
      _localUsageCount = widget.prompt!.usageCount;
    } else {
      _loadPrompt();
    }
  }

  void _loadPrompt() async {
    _promptFuture = FirestoreService().getPrompt(widget.promptId);
    final p = await _promptFuture;
    if (p != null && mounted) {
      setState(() {
        _localUsageCount = p.usageCount;
      });
    }
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final promptProv = Provider.of<PromptProvider>(context);
    final isFav = promptProv.isFavorite(widget.promptId);
    final theme = Theme.of(context);

    _promptFuture ??= widget.prompt != null 
        ? Future.value(widget.prompt) 
        : FirestoreService().getPrompt(widget.promptId);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: FutureBuilder<PromptModel?>(
        future: _promptFuture,
        builder: (context, snap) {
          if (snap.hasData) {
            final p = snap.data!;
            return _buildContent(p, promptProv, isFav);
          }
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: AppColors.primary));
          }
          return const Center(child: Text("Prompt not found"));
        },
      ),
    );
  }

  Widget _buildContent(PromptModel p, PromptProvider promptProv, bool isFav) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollCtrl,
          child: Column(
            children: [
              _buildHero(p),
              _buildBody(p, promptProv, isFav),
            ],
          ),
        ),
        _buildFloatingNav(isFav, promptProv, p),
      ],
    );
  }

  Widget _buildHero(PromptModel p) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: _scrollCtrl,
      builder: (context, child) {
        double offset = 0;
        if (_scrollCtrl.hasClients) {
          offset = _scrollCtrl.offset * 0.3;
        }

        return Transform.translate(
          offset: Offset(0, offset),
          child: child,
        );
      },
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 420,
            child: Hero(
              tag: p.id,
              child: CachedNetworkImage(
                imageUrl: p.exampleImageUrl ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: theme.colorScheme.surfaceVariant.withOpacity(0.3)),
                errorWidget: (context, url, error) => Center(
                  child: Icon(Icons.image_outlined, size: 50, color: theme.colorScheme.onSurfaceVariant.withOpacity(0.3)),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -1,
            left: 0,
            right: 0,
            height: 120,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, theme.scaffoldBackgroundColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingNav(bool isFav, PromptProvider prov, PromptModel p) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 16,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _circleIconBtn(Icons.arrow_back_rounded, () => Navigator.pop(context)),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  prov.toggleFavorite(widget.promptId);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: theme.cardColor.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.2 : 0.08), blurRadius: 15, offset: const Offset(0, 5))],
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                    child: Icon(
                      isFav ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                      key: ValueKey(isFav),
                      color: isFav ? AppColors.primary : theme.iconTheme.color,
                      size: 22,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              _circleIconBtn(Icons.share_rounded, () {
                Share.share('${p.title}\n\n${p.text}\n\n— via NEXORA ✨');
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleIconBtn(IconData icon, VoidCallback tap, {Color? color}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: tap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: theme.cardColor.withOpacity(0.9),
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.2 : 0.08), blurRadius: 15, offset: const Offset(0, 5))],
        ),
        child: Icon(icon, color: color ?? theme.iconTheme.color, size: 22),
      ),
    );
  }

  Widget _buildBody(PromptModel p, PromptProvider prov, bool isFav) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _animatedItem(0, _buildPlatformBadge(p.platform)),
          _animatedItem(1, const SizedBox(height: 16)),
          _animatedItem(2, Text(
            p.title,
            style: GoogleFonts.dmSans(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              height: 1.1,
              color: theme.textTheme.displayLarge?.color,
            ),
          )),
          _animatedItem(3, const SizedBox(height: 12)),
          _animatedItem(4, Wrap(spacing: 8, runSpacing: 8, children: p.tags.map((tag) => _tagWidget(tag)).toList())),
          _animatedItem(5, const SizedBox(height: 35)),
          _animatedItem(6, _sectionLabel("DESCRIPTION")),
          _animatedItem(7, const SizedBox(height: 10)),
          _animatedItem(8, Text(
            p.description,
            style: GoogleFonts.dmSans(
              fontSize: 16, 
              height: 1.6, 
              color: theme.textTheme.bodyLarge?.color?.withOpacity(0.8), 
              fontWeight: FontWeight.w500
            ),
          )),
          _animatedItem(9, const SizedBox(height: 35)),
          _animatedItem(10, _sectionLabel("THE PROMPT")),
          _animatedItem(11, const SizedBox(height: 15)),
          _animatedItem(12, _buildPromptContainer(p.text)),
          _animatedItem(13, const SizedBox(height: 25)),
          if (_localUsageCount > 0)
            _animatedItem(14, _infoChip(Icons.copy_all_rounded, "$_localUsageCount Copies")),
          _animatedItem(15, const SizedBox(height: 40)),
          _animatedItem(16, _mainGradientButton(
            text: "COPY PROMPT",
            icon: Icons.copy_rounded,
            onTap: () {
              Clipboard.setData(ClipboardData(text: p.text));
              HapticFeedback.heavyImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  content: const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 10),
                      Text("Copied successfully!", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              );
              prov.incrementUsageCount(p.id);
              setState(() {
                _localUsageCount++;
              });
            },
          )),
          _animatedItem(17, const SizedBox(height: 14)),
          _animatedItem(18, _outlineButton(p)),
        ],
      ),
    );
  }

  Widget _animatedItem(int index, Widget child) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 400 + (index * 80)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: child,
    );
  }

  Widget _buildPlatformBadge(String platform) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        gradient: AppColors.navGradient,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        platform.toUpperCase(),
        style: GoogleFonts.inter(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(width: 4, height: 15, decoration: BoxDecoration(gradient: AppColors.navGradient, borderRadius: BorderRadius.circular(10))),
        const SizedBox(width: 8),
        Text(text, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w900, color: theme.colorScheme.onSurfaceVariant.withOpacity(0.6), letterSpacing: 1.5)),
      ],
    );
  }

  Widget _tagWidget(String tag) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? theme.colorScheme.surfaceVariant.withOpacity(0.3) : const Color(0xFFF5F7FF),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: theme.dividerColor.withOpacity(isDark ? 0.1 : 0.5)),
      ),
      child: Text("#$tag", style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.bold)),
    );
  }

  Widget _infoChip(IconData icon, String label) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? theme.colorScheme.surfaceVariant.withOpacity(0.3) : const Color(0xFFF5F7FF), 
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(label, style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.bold, color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7))),
        ],
      ),
    );
  }

  Widget _buildPromptContainer(String text) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? theme.cardColor : const Color(0xFFF9FAFF),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.dividerColor.withOpacity(isDark ? 0.1 : 0.5)),
        boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(22),
            child: SelectableText(
              text,
              style: GoogleFonts.dmSans(fontSize: 16, height: 1.6, color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? theme.colorScheme.surfaceVariant.withOpacity(0.3) : const Color(0xFFF1F4FF),
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.auto_awesome, size: 16, color: AppColors.primary.withOpacity(0.4)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _mainGradientButton({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        double scale = 1;

        return GestureDetector(
          onTapDown: (_) => setState(() => scale = 0.96),
          onTapUp: (_) {
            setState(() => scale = 1);
            onTap();
          },
          onTapCancel: () => setState(() => scale = 1),
          child: AnimatedScale(
            scale: scale,
            duration: const Duration(milliseconds: 120),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                gradient: AppColors.navGradient,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(text,
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          letterSpacing: 1)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _outlineButton(PromptModel p) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: OutlinedButton(
        onPressed: () {
          if (p.platformUrl.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebViewScreen(
                  url: p.platformUrl,
                  title: p.platform.toUpperCase(),
                ),
              ),
            );
          }
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: theme.dividerColor.withOpacity(isDark ? 0.2 : 0.5), width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        child: Text("OPEN IN ${p.platform.toUpperCase()}",
            style: GoogleFonts.inter(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1)),
      ),
    );
  }
}
