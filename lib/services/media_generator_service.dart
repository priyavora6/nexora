// lib/services/media_generator_service.dart

import 'image_generator_service.dart';
import 'video_generator_service.dart';

class MediaGeneratorService {
  final ImageGeneratorService _imageGen = ImageGeneratorService();
  final VideoGeneratorService _videoGen = VideoGeneratorService();

  /// Check if category needs videos
  bool needsVideo(String category, String subcategory) {
    const videoCategories = [
      'Image to Video',
      'AI Video Creation',
    ];

    return videoCategories.contains(category);
  }

  /// Generate image (always)
  Future<String> generateImage({
    required String promptText,
    required String title,
    required String category,
  }) async {
    return await _imageGen.generateImage(promptText, title, category);
  }

  /// Generate video (selective)
  Future<String> generateVideo({
    required String promptText,
    required String title,
    required String category,
    required String subcategory,
    String? imageUrl,
  }) async {
    // Image to Video
    if (category == 'Image to Video' && imageUrl != null && imageUrl.isNotEmpty) {
      return await _videoGen.generateImageToVideo(imageUrl, title);
    }

    // Text to Video
    if (category == 'AI Video Creation') {
      return await _videoGen.generateTextToVideo(promptText, title);
    }

    return '';
  }
}