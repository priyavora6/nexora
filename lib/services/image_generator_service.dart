// lib/services/image_generator_service.dart
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ImageGeneratorService {
  // 🔑 CLOUDFLARE CREDENTIALS
  static const String _cfAccountId = 'f52d7092bb7c9c64d0550cdee55cb13c';
  static const String _cfApiToken = 'cfut_MHvbtiay497V80LhWK76AmPmjIQxVqBDcZL2PaAg357a61fe';

  // ☁️ CLOUDINARY
  static const String cloudinaryCloudName = 'dli0cf2x3';
  static const String cloudinaryUploadPreset = 'nexora_unsigned';

  // 🤖 CLOUDFLARE MODEL
  static const String _model = '@cf/black-forest-labs/flux-1-schnell';

  static String get _cfEndpoint =>
      'https://api.cloudflare.com/client/v4/accounts/$_cfAccountId/ai/run/$_model';

  Future<String> generateImage(String promptText, String title, String category) async {
    try {
      print('\n[$title]');

      final Uint8List? imageBytes = await _generateWithCloudflare(promptText);
      if (imageBytes == null) return '';

      await Future.delayed(const Duration(seconds: 2));

      return await _uploadToCloudinary(imageBytes, title, category);

    } catch (e) {
      print('   ❌ Process Error: $e');
      return '';
    }
  }

  Future<Uint8List?> _generateWithCloudflare(String prompt) async {
    try {
      print('   ⚡ Cloudflare AI: Generating...');

      final response = await http.post(
        Uri.parse(_cfEndpoint),
        headers: {
          'Authorization': 'Bearer $_cfApiToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'prompt': '$prompt, high quality, 8k, masterpiece',
          'negative_prompt': 'blurry, low quality, distorted, ugly',
          'width': 512,
          'height': 512,
          'num_inference_steps': 4,
        }),
      ).timeout(const Duration(seconds: 60));

      print('      📦 Status: ${response.statusCode}');

      if (response.statusCode != 200) {
        print('   ❌ Cloudflare Error: ${response.statusCode} - ${response.body}');
        return null;
      }

      final contentType = response.headers['content-type'] ?? '';

      if (contentType.contains('image/')) {
        print('      ✅ Got raw bytes (${response.bodyBytes.length} bytes)');
        return response.bodyBytes;
      }

      if (contentType.contains('application/json')) {
        final json = jsonDecode(response.body);

        if (json['result']?['image'] != null) {
          final bytes = base64Decode(json['result']['image'] as String);
          print('      ✅ Decoded base64 (${bytes.length} bytes)');
          return bytes;
        }
        if (json['result'] is List && json['result'][0]['url'] != null) {
          final imgRes = await http.get(Uri.parse(json['result'][0]['url'] as String));
          return imgRes.bodyBytes;
        }
        if (json['image'] != null) {
          return base64Decode(json['image'] as String);
        }
      }

      return response.bodyBytes;

    } catch (e) {
      print('   ❌ Generation Error: $e');
      return null;
    }
  }

  /// ✅ Upload directly via dart:io HttpClient — no temp file, no path_provider needed
  Future<String> _uploadToCloudinary(Uint8List bytes, String title, String category) async {
    final publicId = _makePublicId(title, category);

    for (int attempt = 1; attempt <= 3; attempt++) {
      try {
        print('   ☁️  Uploading (Attempt $attempt) [${bytes.length} bytes]...');

        final httpClient = HttpClient();
        httpClient.connectionTimeout = const Duration(seconds: 30);

        final ioRequest = await httpClient.postUrl(
          Uri.parse('https://api.cloudinary.com/v1_1/$cloudinaryCloudName/image/upload'),
        );

        // Build multipart body in memory — no file system needed
        final boundary = 'nexora${DateTime.now().millisecondsSinceEpoch}';
        ioRequest.headers.set(
          HttpHeaders.contentTypeHeader,
          'multipart/form-data; boundary=$boundary',
        );

        final bodyBuilder = BytesBuilder();

        void addField(String name, String value) {
          bodyBuilder.add('--$boundary\r\n'.codeUnits);
          bodyBuilder.add('Content-Disposition: form-data; name="$name"\r\n\r\n'.codeUnits);
          bodyBuilder.add('$value\r\n'.codeUnits);
        }

        addField('upload_preset', cloudinaryUploadPreset);
        addField('public_id', publicId);

        // File field with raw PNG bytes
        bodyBuilder.add('--$boundary\r\n'.codeUnits);
        bodyBuilder.add('Content-Disposition: form-data; name="file"; filename="image.png"\r\n'.codeUnits);
        bodyBuilder.add('Content-Type: image/png\r\n\r\n'.codeUnits);
        bodyBuilder.add(bytes);
        bodyBuilder.add('\r\n'.codeUnits);
        bodyBuilder.add('--$boundary--\r\n'.codeUnits);

        final bodyBytes = bodyBuilder.toBytes();
        ioRequest.headers.set(HttpHeaders.contentLengthHeader, bodyBytes.length.toString());
        ioRequest.add(bodyBytes);

        final ioResponse = await ioRequest.close().timeout(const Duration(minutes: 3));
        final responseBody = await ioResponse.transform(utf8.decoder).join();
        httpClient.close();

        if (ioResponse.statusCode == 200 || ioResponse.statusCode == 201) {
          final data = jsonDecode(responseBody);
          final url = data['secure_url'] as String;
          print('      ✅ SUCCESS! → $url');
          return url;
        }

        print('      ⚠️ Cloudinary ${ioResponse.statusCode}: $responseBody');
        if (attempt < 3) {
          print('      ⏳ Waiting 20s...');
          await Future.delayed(const Duration(seconds: 20));
        }

      } catch (e) {
        print('      ⚠️ Attempt $attempt error: $e');
        if (attempt < 3) {
          print('      ⏳ Waiting 20s...');
          await Future.delayed(const Duration(seconds: 20));
        }
      }
    }

    print('   ❌ All attempts failed for: $title');
    return '';
  }

  String _makePublicId(String title, String category) {
    return 'nexora_${_superClean(category)}_${_superClean(title)}';
  }

  String _superClean(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '')
        .trim();
  }
}