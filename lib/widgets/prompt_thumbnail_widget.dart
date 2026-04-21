import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PromptThumbnailWidget extends StatelessWidget {
  final String? imageUrl;
  final String? thumbnailUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool showPlayIcon; // For video thumbnails
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final Alignment alignment; // 👈 Added alignment parameter

  const PromptThumbnailWidget({
    Key? key,
    this.imageUrl,
    this.thumbnailUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.showPlayIcon = false,
    this.onTap,
    this.borderRadius,
    this.alignment = Alignment.topCenter, // 👈 Default to topCenter to avoid cutting heads
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveUrl = thumbnailUrl ?? imageUrl;

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image or Video Placeholder
              _buildMainContent(effectiveUrl),

              // Gradient overlay
              if (showPlayIcon)
                _buildGradientOverlay(),

              // Play icon (for videos)
              if (showPlayIcon) _buildPlayIcon(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(String? url) {
    if (url == null || url.isEmpty) {
      // If it's a video but has no image, show a nicer video placeholder
      if (showPlayIcon) {
        return Container(
          color: Colors.grey.shade900,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.movie_creation_outlined, size: 40, color: Colors.white.withOpacity(0.5)),
              const SizedBox(height: 8),
              Text(
                'Video Preview',
                style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
              ),
            ],
          ),
        );
      }
      return _buildPlaceholder();
    }

    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      alignment: alignment, // 👈 Use the alignment property here
      placeholder: (context, url) => _buildLoadingPlaceholder(),
      errorWidget: (context, url, error) => _buildErrorPlaceholder(),
      fadeInDuration: const Duration(milliseconds: 300),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey.shade200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 8),
          Text(
            'No preview',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingPlaceholder() {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black.withOpacity(0.4)],
        ),
      ),
    );
  }

  Widget _buildPlayIcon() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
        ),
        child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 40),
      ),
    );
  }
}
