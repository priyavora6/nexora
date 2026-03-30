import 'package:flutter/material.dart';
import '../config//app_constants.dart';

class PlatformBadgeWidget extends StatelessWidget {
  final String platform; // Display name like "Midjourney"
  final String? platformKey; // Optional key for color lookup
  final bool isClickable;
  final VoidCallback? onTap;
  final PlatformBadgeSize size;

  const PlatformBadgeWidget({
    Key? key,
    required this.platform,
    this.platformKey,
    this.isClickable = false,
    this.onTap,
    this.size = PlatformBadgeSize.medium,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveKey = platformKey ??
        AppConstants.platformKeys[platform]?.toLowerCase() ??
        'other';

    final colorHex = AppConstants.platformColors[effectiveKey] ?? '#6B7280';
    final color = _hexToColor(colorHex);

    final badgeWidget = Container(
      padding: _getPadding(),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(_getBorderRadius()),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIcon(effectiveKey, color),
          if (size != PlatformBadgeSize.small) ...[
            SizedBox(width: _getSpacing()),
            Text(
              platform,
              style: TextStyle(
                color: color,
                fontSize: _getFontSize(),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );

    if (isClickable && onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_getBorderRadius()),
        child: badgeWidget,
      );
    }

    return badgeWidget;
  }

  Widget _buildIcon(String platformKey, Color color) {
    IconData iconData;

    switch (platformKey) {
      case 'midjourney':
      case 'leonardo':
      case 'dalle':
      case 'stable_diffusion':
      case 'ideogram':
        iconData = Icons.image;
        break;
      case 'kling':
      case 'runway':
      case 'sora':
      case 'luma':
      case 'pika':
        iconData = Icons.videocam;
        break;
      case 'chatgpt':
        iconData = Icons.chat_bubble;
        break;
      case 'firefly':
        iconData = Icons.auto_awesome;
        break;
      default:
        iconData = Icons.apps;
    }

    return Icon(
      iconData,
      size: _getIconSize(),
      color: color,
    );
  }

  double _getIconSize() {
    switch (size) {
      case PlatformBadgeSize.small:
        return 14;
      case PlatformBadgeSize.medium:
        return 16;
      case PlatformBadgeSize.large:
        return 20;
    }
  }

  double _getFontSize() {
    switch (size) {
      case PlatformBadgeSize.small:
        return 11;
      case PlatformBadgeSize.medium:
        return 13;
      case PlatformBadgeSize.large:
        return 15;
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case PlatformBadgeSize.small:
        return const EdgeInsets.symmetric(horizontal: 6, vertical: 4);
      case PlatformBadgeSize.medium:
        return const EdgeInsets.symmetric(horizontal: 10, vertical: 6);
      case PlatformBadgeSize.large:
        return const EdgeInsets.symmetric(horizontal: 14, vertical: 8);
    }
  }

  double _getBorderRadius() {
    switch (size) {
      case PlatformBadgeSize.small:
        return 6;
      case PlatformBadgeSize.medium:
        return 8;
      case PlatformBadgeSize.large:
        return 10;
    }
  }

  double _getSpacing() {
    switch (size) {
      case PlatformBadgeSize.small:
        return 4;
      case PlatformBadgeSize.medium:
        return 6;
      case PlatformBadgeSize.large:
        return 8;
    }
  }

  Color _hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

// ═══════════════════════════════════════════════
// PLATFORM BADGE SIZE ENUM
// ═══════════════════════════════════════════════

enum PlatformBadgeSize {
  small,  // Icon only or very compact
  medium, // Default size
  large,  // Prominent display
}