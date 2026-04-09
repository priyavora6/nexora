// lib/services/media_generator_service.dart

import 'image_generator_service.dart';

class MediaGeneratorService {
  final ImageGeneratorService _imageGen = ImageGeneratorService();

  /// Generate image
  Future<String> generateImage({
    required String promptText,
    required String title,
    required String category,
  }) async {
    return await _imageGen.generateImage(promptText, title, category);
  }
}