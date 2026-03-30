import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CloudinaryService {
  // ═══════════════════════════════════════
  // 🔧 CONFIGURATION
  // ═══════════════════════════════════════
  static const String _cloudName = 'dli0cf2x3';
  static const String _uploadPreset = 'nexora_unsigned'; 

  CloudinaryService();

  // ═══════════════════════════════════════
  // 📤 UPLOAD IMAGE (Pure Dart / No Flutter)
  // ═══════════════════════════════════════

  Future<CloudinaryUploadResult> uploadImage(
    File imageFile, {
    String folder = 'nexora/examples',
    String? fileName,
  }) async {
    try {
      final url = Uri.parse('https://api.cloudinary.com/v1_1/$_cloudName/image/upload');
      
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = _uploadPreset
        ..fields['folder'] = folder
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      if (fileName != null) {
        request.fields['public_id'] = fileName;
      }

      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      final decodedData = jsonDecode(responseData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final secureUrl = decodedData['secure_url'];
        final publicId = decodedData['public_id'];
        final format = decodedData['format'];

        return CloudinaryUploadResult(
          success: true,
          url: secureUrl,
          thumbnailUrl: _generateThumbnailUrl(secureUrl),
          publicId: publicId,
          format: format,
        );
      } else {
        return CloudinaryUploadResult(
          success: false,
          errorMessage: decodedData['error']?['message'] ?? 'Upload failed',
        );
      }
    } catch (e) {
      print('❌ Cloudinary upload error: $e');
      return CloudinaryUploadResult(
        success: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<List<CloudinaryUploadResult>> uploadMultipleImages(
    List<File> imageFiles, {
    String folder = 'nexora/hero',
    Function(int current, int total)? onProgress,
  }) async {
    List<CloudinaryUploadResult> results = [];

    for (int i = 0; i < imageFiles.length; i++) {
      if (onProgress != null) {
        onProgress(i + 1, imageFiles.length);
      }

      final result = await uploadImage(
        imageFiles[i],
        folder: folder,
        fileName: 'hero_${i + 1}_${DateTime.now().millisecondsSinceEpoch}',
      );

      results.add(result);
    }

    return results;
  }

  String _generateThumbnailUrl(String originalUrl) {
    if (!originalUrl.contains('/upload/')) return originalUrl;
    return originalUrl.replaceFirst(
      '/upload/',
      '/upload/c_thumb,w_300,h_300,g_auto/',
    );
  }

  String getOptimizedUrl(
    String originalUrl, {
    int? width,
    int? height,
    String? quality,
    String? format,
  }) {
    if (!originalUrl.contains('/upload/')) return originalUrl;

    List<String> transformations = [];
    if (width != null) transformations.add('w_$width');
    if (height != null) transformations.add('h_$height');
    if (quality != null) transformations.add('q_$quality');
    if (format != null) transformations.add('f_$format');

    final transform = transformations.join(',');
    return originalUrl.replaceFirst('/upload/', '/upload/$transform/');
  }

  String getThumbnailUrl(String originalUrl, {int size = 200}) {
    return getOptimizedUrl(originalUrl, width: size, height: size, quality: 'auto');
  }

  String getResponsiveUrl(String originalUrl) {
    return getOptimizedUrl(originalUrl, width: 800, quality: 'auto:good', format: 'auto');
  }

  Future<bool> deleteImage(String publicId) async {
    print('⚠️ Delete image requested for: $publicId');
    return true; 
  }

  String? validateImageFile(File imageFile) {
    if (!imageFile.existsSync()) return 'File does not exist';
    final fileSize = imageFile.lengthSync();
    if (fileSize > 10 * 1024 * 1024) return 'File too large (max 10MB)';
    final extension = imageFile.path.split('.').last.toLowerCase();
    if (!['jpg', 'jpeg', 'png', 'webp', 'gif'].contains(extension)) {
      return 'Invalid file type (use JPG, PNG, or WEBP)';
    }
    return null;
  }

  String? extractPublicId(String cloudinaryUrl) {
    try {
      final uri = Uri.parse(cloudinaryUrl);
      final pathSegments = uri.pathSegments;
      final uploadIndex = pathSegments.indexOf('upload');
      if (uploadIndex == -1) return null;
      final publicIdSegments = pathSegments.skip(uploadIndex + 2);
      final publicIdWithExt = publicIdSegments.join('/');
      return publicIdWithExt.substring(0, publicIdWithExt.lastIndexOf('.'));
    } catch (e) {
      print('❌ Extract public ID error: $e');
      return null;
    }
  }

  bool isCloudinaryUrl(String url) => url.contains('cloudinary.com');
}

class CloudinaryUploadResult {
  final bool success;
  final String? url;
  final String? thumbnailUrl;
  final String? publicId;
  final String? format;
  final String? errorMessage;

  CloudinaryUploadResult({
    required this.success,
    this.url,
    this.thumbnailUrl,
    this.publicId,
    this.format,
    this.errorMessage,
  });

  bool get isImage => format != null && ['jpg', 'jpeg', 'png', 'webp', 'gif'].contains(format);
}
