import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../config/app_colors.dart';
import '../../models/prompt_model.dart';
import '../../providers/prompt_provider.dart';
import '../../services/firestore_service.dart';
import '../../utils/deep_link_helper.dart';
import '../../widgets/generate_button_widget.dart';
import '../../widgets/video_player_widget.dart';

class PromptDetailScreen extends StatefulWidget {
  final String promptId;
  const PromptDetailScreen({Key? key, required this.promptId}) : super(key: key);

  @override
  State<PromptDetailScreen> createState() => _PromptDetailScreenState();
}

class _PromptDetailScreenState extends State<PromptDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  final ScrollController _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final promptProv = Provider.of<PromptProvider>(context);
    final isFav = promptProv.isFavorite(widget.promptId);

    return Scaffold(
      backgroundColor: AppColors.lightScaffold,
      body: FutureBuilder<PromptModel?>(
        future: FirestoreService().getPrompt(widget.promptId),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const _LoadingState();
          }
          if (!snap.hasData || snap.data == null) {
            return const _EmptyState();
          }

          final p = snap.data!;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!_fadeCtrl.isCompleted) _fadeCtrl.forward();
          });

          return Stack(
            children: [
              // ── MAIN CONTENT ──
              SingleChildScrollView(
                controller: _scrollCtrl,
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── HERO: full image, no crop ──
                    _HeroSection(prompt: p),

                    // ── CONTENT ──
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: SlideTransition(
                        position: _slideAnim,
                        child: _ContentBody(prompt: p),
                      ),
                    ),
                  ],
                ),
              ),

              // ── FLOATING NAVIGATION ──
              Positioned(
                top: MediaQuery.of(context).padding.top + 10,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _FloatingButton(
                      icon: Icons.arrow_back_rounded,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Row(
                      children: [
                        _FloatingButton(
                          icon: isFav ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                          iconColor: isFav ? AppColors.royalBlue : AppColors.textPrimary,
                          onPressed: () {
                            HapticFeedback.mediumImpact();
                            promptProv.toggleFavorite(widget.promptId);
                          },
                        ),
                        const SizedBox(width: 12),
                        _FloatingButton(
                          icon: Icons.share_rounded,
                          onPressed: () async {
                            Share.share('${p.title}\n\n${p.text}\n\n— via Nexora');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
// FLOATING BUTTON COMPONENT
// ─────────────────────────────────────────────
class _FloatingButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? iconColor;

  const _FloatingButton({
    required this.icon,
    required this.onPressed,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: iconColor ?? AppColors.textPrimary, size: 22),
        onPressed: onPressed,
      ),
    );
  }
}

// ─────────────────────────────────────────────
// LOADING STATE
// ─────────────────────────────────────────────
class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
              color: AppColors.royalBlue, strokeWidth: 2),
          const SizedBox(height: 16),
          Text('Loading prompt…',
              style: GoogleFonts.dmSans(
                  color: AppColors.textHint, fontSize: 13)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// EMPTY STATE
// ─────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off_rounded,
              size: 48, color: AppColors.textHint.withOpacity(0.4)),
          const SizedBox(height: 14),
          Text('Prompt not found.',
              style: GoogleFonts.playfairDisplay(
                  fontSize: 18,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text('It may have been removed or moved.',
              style: GoogleFonts.dmSans(
                  fontSize: 13, color: AppColors.textHint)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// HERO SECTION — full image, BoxFit.contain (no crop)
// ─────────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  final PromptModel prompt;
  const _HeroSection({required this.prompt});

  @override
  Widget build(BuildContext context) {
    final scaffoldColor = AppColors.lightScaffold;
    final hasImage = prompt.hasExample &&
        prompt.exampleImageUrl != null &&
        prompt.exampleImageUrl!.isNotEmpty;
    final hasVideo = prompt.hasVideoExample;

    if (!hasImage && !hasVideo) return _NoMediaHero();

    return Stack(
      children: [
        // ── MEDIA ──
        Container(
          color: const Color(0xFFF0F2F8),
          width: double.infinity,
          child: hasVideo
              ? AspectRatio(
            aspectRatio: 16 / 9,
            child: VideoPlayerWidget(
                videoUrl: prompt.exampleVideoUrl!, autoPlay: true),
          )
              : Hero(
            tag: prompt.id,
            child: Image.network(
              prompt.exampleImageUrl!,
              fit: BoxFit.contain, // ← full image, zero crop
              width: double.infinity,
              frameBuilder: (_, child, frame, __) {
                if (frame == null) {
                  return Container(
                    height: 300,
                    color: const Color(0xFFF0F2F8),
                    child: const Center(
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: AppColors.royalBlue),
                    ),
                  );
                }
                return child;
              },
              errorBuilder: (_, __, ___) => Container(
                height: 260,
                color: const Color(0xFFF0F2F8),
                child: const Center(
                  child: Icon(Icons.image_outlined,
                      size: 48, color: Color(0xFFBBC2D8)),
                ),
              ),
            ),
          ),
        ),

        // ── Bottom melt into scaffold ──
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 130,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  scaffoldColor.withOpacity(0.55),
                  scaffoldColor,
                ],
                stops: const [0.0, 0.6, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NoMediaHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.royalBlue.withOpacity(0.10),
            AppColors.indigo.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(Icons.auto_awesome_rounded,
            size: 52, color: AppColors.royalBlue.withOpacity(0.22)),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// CONTENT BODY
// ─────────────────────────────────────────────
class _ContentBody extends StatelessWidget {
  final PromptModel prompt;
  const _ContentBody({required this.prompt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PlatformBadge(platform: prompt.platform),
          const SizedBox(height: 20),

          // Title
          Text(
            prompt.title,
            style: GoogleFonts.playfairDisplay(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              height: 1.18,
              letterSpacing: -0.4,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),

          // Tags
          if (prompt.tags.isNotEmpty) ...[
            _TagsRow(tags: prompt.tags),
            const SizedBox(height: 40),
          ] else
            const SizedBox(height: 40),

          // Description
          _SectionLabel(label: 'DESCRIPTION'),
          const SizedBox(height: 14),
          Text(
            prompt.description,
            style: GoogleFonts.dmSans(
              fontSize: 15.5,
              height: 1.75,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 40),

          // Prompt box
          _SectionLabel(label: 'THE PROMPT'),
          const SizedBox(height: 16),
          _PromptBox(text: prompt.text),

          const SizedBox(height: 28),

          // Info chips
          _InfoRow(prompt: prompt),

          const SizedBox(height: 36),

          // CTA
          GenerateButtonWidget(
            prompt: prompt,
            showRedirect: false,
            style: GenerateButtonStyle.primary,
          ),

          const SizedBox(height: 14),

          if (prompt.platformUrl.isNotEmpty || prompt.platformKey.isNotEmpty)
            _PlatformLinkButton(prompt: prompt),

          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PLATFORM BADGE
// ─────────────────────────────────────────────
class _PlatformBadge extends StatelessWidget {
  final String platform;
  const _PlatformBadge({required this.platform});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.royalBlue.withOpacity(0.09),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_awesome_rounded,
              color: AppColors.royalBlue, size: 13),
          const SizedBox(width: 6),
          Text(
            platform.toUpperCase(),
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w800,
              color: AppColors.royalBlue,
              fontSize: 10.5,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TAGS ROW
// ─────────────────────────────────────────────
class _TagsRow extends StatelessWidget {
  final List<String> tags;
  const _TagsRow({required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags
          .map((tag) => Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: AppColors.lightInput,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: AppColors.border.withOpacity(0.5)),
        ),
        child: Text(
          '#${tag.toLowerCase()}',
          style: GoogleFonts.dmSans(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.indigo,
            letterSpacing: 0.2,
          ),
        ),
      ))
          .toList(),
    );
  }
}

// ─────────────────────────────────────────────
// SECTION LABEL
// ─────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 14,
          decoration: BoxDecoration(
            color: AppColors.royalBlue,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: GoogleFonts.dmSans(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
            color: AppColors.indigo.withOpacity(0.75),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// INFO ROW — usage count + read time
// ─────────────────────────────────────────────
class _InfoRow extends StatelessWidget {
  final PromptModel prompt;
  const _InfoRow({required this.prompt});

  String _fmt(int n) =>
      n >= 1000 ? '${(n / 1000).toStringAsFixed(1)}k' : n.toString();

  String get _readTime {
    final secs =
    ((prompt.text.split(' ').length / 200) * 60).ceil();
    return secs < 60
        ? '~${secs}s read'
        : '~${(secs / 60).ceil()}m read';
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: [
        if (prompt.usageCount != null)
          _InfoChip(
              icon: Icons.people_outline_rounded,
              label: '${_fmt(prompt.usageCount!)} uses'),
        _InfoChip(icon: Icons.timer_outlined, label: _readTime),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.lightInput,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.textHint),
          const SizedBox(width: 5),
          Text(label,
              style: GoogleFonts.dmSans(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textHint)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PROMPT BOX
// ─────────────────────────────────────────────
class _PromptBox extends StatefulWidget {
  final String text;
  const _PromptBox({required this.text});

  @override
  State<_PromptBox> createState() => _PromptBoxState();
}

class _PromptBoxState extends State<_PromptBox>
    with SingleTickerProviderStateMixin {
  bool _copied = false;
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 220));
    _scaleAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.22), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.22, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.text));
    HapticFeedback.lightImpact();
    _ctrl.forward(from: 0);
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7FB),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border.withOpacity(0.45)),
        boxShadow: [
          BoxShadow(
            color: AppColors.royalBlue.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 16, 14),
            child: Row(
              children: [
                const Icon(Icons.format_quote_rounded,
                    color: AppColors.royalBlue, size: 22),
                const SizedBox(width: 8),
                Text('Prompt',
                    style: GoogleFonts.dmSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textHint)),
                const Spacer(),
                GestureDetector(
                  onTap: _copy,
                  child: AnimatedBuilder(
                    animation: _scaleAnim,
                    builder: (_, child) => Transform.scale(
                        scale: _scaleAnim.value, child: child),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 260),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: _copied
                            ? AppColors.royalBlue.withOpacity(0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _copied
                              ? AppColors.royalBlue.withOpacity(0.35)
                              : AppColors.border.withOpacity(0.5),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _copied
                                ? Icons.check_rounded
                                : Icons.copy_rounded,
                            size: 13,
                            color: _copied
                                ? AppColors.royalBlue
                                : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _copied ? 'Copied!' : 'Copy',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: _copied
                                  ? AppColors.royalBlue
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(
              height: 1,
              thickness: 1,
              color: AppColors.border.withOpacity(0.35)),

          // Prompt text
          Padding(
            padding: const EdgeInsets.all(22),
            child: SelectableText(
              widget.text,
              style: GoogleFonts.dmSans(
                fontSize: 15.5,
                height: 1.82,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Footer: char + word count
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: 22, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.border.withOpacity(0.12),
              borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24)),
            ),
            child: Text(
              '${widget.text.length} characters · ${widget.text.split(' ').length} words',
              style: GoogleFonts.dmSans(
                  fontSize: 11,
                  color: AppColors.textHint,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PLATFORM LINK BUTTON
// ─────────────────────────────────────────────
class _PlatformLinkButton extends StatelessWidget {
  final PromptModel prompt;
  const _PlatformLinkButton({required this.prompt});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (prompt.platformUrl.isNotEmpty) {
          await DeepLinkHelper.openUrl(prompt.platformUrl,
              context: context);
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
              color: AppColors.border.withOpacity(0.7), width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.open_in_new_rounded,
                size: 15, color: AppColors.textSecondary),
            const SizedBox(width: 8),
            Text(
              'Open in ${prompt.platform}',
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
                fontSize: 13.5,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
