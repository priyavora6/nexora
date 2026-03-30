import 'package:flutter/foundation.dart';

class YouTubeService {
  // ═══════════════════════════════════════
  // 🎥 VIDEO ID EXTRACTION
  // ═══════════════════════════════════════

  /// Extract video ID from various YouTube URL formats
  /// Supports:
  /// - https://www.youtube.com/watch?v=VIDEO_ID
  /// - https://youtu.be/VIDEO_ID
  /// - https://www.youtube.com/embed/VIDEO_ID
  /// - https://m.youtube.com/watch?v=VIDEO_ID
  static String? extractVideoId(String input) {
    if (input.isEmpty) return null;

    try {
      // If it's already just the ID (11 characters, alphanumeric + _ -)
      if (RegExp(r'^[a-zA-Z0-9_-]{11}$').hasMatch(input)) {
        return input;
      }

      final uri = Uri.tryParse(input);
      if (uri == null) return null;

      // youtube.com/watch?v=VIDEO_ID
      if (uri.host.contains('youtube.com') && uri.queryParameters.containsKey('v')) {
        return uri.queryParameters['v'];
      }

      // youtu.be/VIDEO_ID
      if (uri.host.contains('youtu.be') && uri.pathSegments.isNotEmpty) {
        return uri.pathSegments.first;
      }

      // youtube.com/embed/VIDEO_ID
      if (uri.host.contains('youtube.com') &&
          uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first == 'embed') {
        return uri.pathSegments.length > 1 ? uri.pathSegments[1] : null;
      }

      return null;
    } catch (e) {
      debugPrint('❌ Extract video ID error: $e');
      return null;
    }
  }

  // ═══════════════════════════════════════
  // 🔗 URL GENERATION
  // ═══════════════════════════════════════

  /// Get YouTube thumbnail URL
  /// Quality options: default, mqdefault, hqdefault, sddefault, maxresdefault
  static String getThumbnailUrl(
      String videoId, {
        YouTubeThumbnailQuality quality = YouTubeThumbnailQuality.high,
      }) {
    String qualityStr;
    switch (quality) {
      case YouTubeThumbnailQuality.low:
        qualityStr = 'default';
        break;
      case YouTubeThumbnailQuality.medium:
        qualityStr = 'mqdefault';
        break;
      case YouTubeThumbnailQuality.high:
        qualityStr = 'hqdefault';
        break;
      case YouTubeThumbnailQuality.standard:
        qualityStr = 'sddefault';
        break;
      case YouTubeThumbnailQuality.max:
        qualityStr = 'maxresdefault';
        break;
    }

    return 'https://img.youtube.com/vi/$videoId/$qualityStr.jpg';
  }

  /// Get YouTube embed URL for iframe
  static String getEmbedUrl(
      String videoId, {
        bool autoplay = false,
        bool controls = true,
        bool showInfo = false,
        int startSeconds = 0,
      }) {
    final params = <String, String>{
      if (autoplay) 'autoplay': '1',
      if (!controls) 'controls': '0',
      if (!showInfo) 'showinfo': '0',
      if (startSeconds > 0) 'start': startSeconds.toString(),
      'rel': '0', // Don't show related videos
      'modestbranding': '1', // Minimal YouTube branding
    };

    final queryString = params.entries
        .map((e) => '${e.key}=${e.value}')
        .join('&');

    return 'https://www.youtube.com/embed/$videoId?$queryString';
  }

  /// Get YouTube watch URL
  static String getWatchUrl(String videoId) {
    return 'https://www.youtube.com/watch?v=$videoId';
  }

  /// Get YouTube share URL (short format)
  static String getShareUrl(String videoId) {
    return 'https://youtu.be/$videoId';
  }

  // ═══════════════════════════════════════
  // ✅ VALIDATION
  // ═══════════════════════════════════════

  /// Validate if string is a valid YouTube video ID
  static bool isValidVideoId(String? videoId) {
    if (videoId == null || videoId.isEmpty) return false;

    // YouTube video IDs are 11 characters: letters, numbers, hyphens, underscores
    return RegExp(r'^[a-zA-Z0-9_-]{11}$').hasMatch(videoId);
  }

  /// Validate YouTube URL and return video ID if valid
  static String? validateAndExtract(String input) {
    final videoId = extractVideoId(input);
    return isValidVideoId(videoId) ? videoId : null;
  }

  // ═══════════════════════════════════════
  // 📊 HELPER METHODS
  // ═══════════════════════════════════════

  /// Check if URL is a YouTube URL
  static bool isYouTubeUrl(String url) {
    try {
      final uri = Uri.tryParse(url);
      if (uri == null) return false;

      return uri.host.contains('youtube.com') ||
          uri.host.contains('youtu.be');
    } catch (e) {
      return false;
    }
  }

  /// Get all thumbnail URLs for a video
  static Map<String, String> getAllThumbnails(String videoId) {
    return {
      'default': getThumbnailUrl(videoId, quality: YouTubeThumbnailQuality.low),
      'medium': getThumbnailUrl(videoId, quality: YouTubeThumbnailQuality.medium),
      'high': getThumbnailUrl(videoId, quality: YouTubeThumbnailQuality.high),
      'standard': getThumbnailUrl(videoId, quality: YouTubeThumbnailQuality.standard),
      'max': getThumbnailUrl(videoId, quality: YouTubeThumbnailQuality.max),
    };
  }

  /// Format duration (seconds to MM:SS or HH:MM:SS)
  static String formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    } else {
      return '${minutes}:${secs.toString().padLeft(2, '0')}';
    }
  }
}

// ═══════════════════════════════════════
// 📦 ENUMS
// ═══════════════════════════════════════

enum YouTubeThumbnailQuality {
  low,      // 120x90
  medium,   // 320x180
  high,     // 480x360
  standard, // 640x480
  max,      // 1280x720 (not always available)
}