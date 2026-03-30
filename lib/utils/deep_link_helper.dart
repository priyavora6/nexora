import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config//app_constants.dart';

class DeepLinkHelper {
  // ═══════════════════════════════════════
  // 🔗 OPEN AI PLATFORM
  // ═══════════════════════════════════════

  /// Open AI platform in browser/app
  static Future<bool> openAIPlatform(
      String platformKey, {
        BuildContext? context,
      }) async {
    final url = AppConstants.platformUrls[platformKey.toLowerCase()];

    if (url == null || url.isEmpty) {
      if (context != null) {
        _showError(context, 'Platform URL not configured');
      }
      return false;
    }

    return await openUrl(url, context: context);
  }

  // ═══════════════════════════════════════
  // 🌐 OPEN URL
  // ═══════════════════════════════════════

  /// Open any URL with error handling
  static Future<bool> openUrl(
      String url, {
        BuildContext? context,
        LaunchMode mode = LaunchMode.externalApplication,
      }) async {
    try {
      final uri = Uri.parse(url);

      if (!await canLaunchUrl(uri)) {
        if (context != null) {
          _showError(context, 'Cannot open this link');
        }
        return false;
      }

      final launched = await launchUrl(uri, mode: mode);

      if (!launched && context != null) {
        _showError(context, 'Failed to open link');
      }

      return launched;
    } catch (e) {
      debugPrint('❌ Open URL error: $e');
      if (context != null) {
        _showError(context, 'Invalid URL');
      }
      return false;
    }
  }

  // ═══════════════════════════════════════
  // 📧 OPEN EMAIL
  // ═══════════════════════════════════════

  /// Open email app with pre-filled data
  static Future<bool> openEmail({
    required String email,
    String? subject,
    String? body,
    BuildContext? context,
  }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      },
    );

    return await openUrl(uri.toString(), context: context);
  }

  // ═══════════════════════════════════════
  // 📱 SHARE
  // ═══════════════════════════════════════

  /// Share text (prompt) to other apps
  /// Note: Requires share_plus package for full functionality
  static Future<void> sharePrompt(
      String promptText, {
        String? subject,
      }) async {
    // For now, just copy to clipboard
    // In production, use share_plus package:
    // await Share.share(promptText, subject: subject);

    debugPrint('📤 Share prompt: $promptText');
  }

  // ═══════════════════════════════════════
  // 🔍 PLATFORM-SPECIFIC HELPERS
  // ═══════════════════════════════════════

  /// Open Midjourney Discord
  static Future<bool> openMidjourney({BuildContext? context}) async {
    return await openAIPlatform('midjourney', context: context);
  }

  /// Open ChatGPT
  static Future<bool> openChatGPT({BuildContext? context}) async {
    return await openAIPlatform('chatgpt', context: context);
  }

  /// Open Kling AI
  static Future<bool> openKling({BuildContext? context}) async {
    return await openAIPlatform('kling', context: context);
  }

  /// Open DALL-E
  static Future<bool> openDallE({BuildContext? context}) async {
    return await openAIPlatform('dalle', context: context);
  }

  /// Open Leonardo AI
  static Future<bool> openLeonardo({BuildContext? context}) async {
    return await openAIPlatform('leonardo', context: context);
  }

  // ═══════════════════════════════════════
  // ✅ VALIDATION
  // ═══════════════════════════════════════

  /// Check if URL can be launched
  static Future<bool> canOpenUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      return await canLaunchUrl(uri);
    } catch (e) {
      return false;
    }
  }

  /// Validate URL format
  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  // ═══════════════════════════════════════
  // 🎨 UI HELPERS
  // ═══════════════════════════════════════

  /// Show error snackbar
  static void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Show success snackbar
  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ═══════════════════════════════════════
  // 📊 ANALYTICS (Future Enhancement)
  // ═══════════════════════════════════════

  /// Track platform link click
  static void trackPlatformClick(String platformKey) {
    // Implement Firebase Analytics tracking
    debugPrint('📊 Platform clicked: $platformKey');
  }

  /// Track external link click
  static void trackLinkClick(String url) {
    debugPrint('📊 Link clicked: $url');
  }
}