import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CloudinaryService {
  // ═══════════════════════════════════════
  // 🔧 CONFIGURATION (Loaded from .env)
  // ═══════════════════════════════════════
  static String get _cloudName => dotenv.get('CLOUDINARY_CLOUD_NAME', fallback: '');
  static String get _uploadPreset => dotenv.get('CLOUDINARY_UPLOAD_PRESET', fallback: '');
  static String get _apiKey => dotenv.get('CLOUDINARY_API_KEY', fallback: '');
  static String get _apiSecret => dotenv.get('CLOUDINARY_API_SECRET', fallback: '');

  CloudinaryService();

  // ═══════════════════════════════════════
  // 📤 UPLOAD IMAGE
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
    if (publicId.isEmpty) return false;

    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final signatureString = 'public_id=$publicId&timestamp=$timestamp$_apiSecret';
      final signature = sha1.convert(utf8.encode(signatureString)).toString();

      final response = await http.post(
        Uri.parse('https://api.cloudinary.com/v1_1/$_cloudName/image/destroy'),
        body: {
          'public_id': publicId,
          'api_key': _apiKey,
          'timestamp': timestamp.toString(),
          'signature': signature,
        },
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['result'] == 'ok';
      }
      return false;
    } catch (e) {
      print('❌ Cloudinary delete error: $e');
      return false;
    }
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
      
      int startIndex = uploadIndex + 1;
      if (startIndex < pathSegments.length &&
          pathSegments[startIndex].startsWith('v') &&
          int.tryParse(pathSegments[startIndex].substring(1)) != null) {
        startIndex++;
      }

      final publicIdSegments = pathSegments.skip(startIndex);
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
