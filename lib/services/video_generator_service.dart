// lib/services/video_generator_service.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

// ================================================================
//  HOW TO GET YOUR FREE PIXVERSE API KEY:
//  1. Go to https://platform.pixverse.ai
//  2. Sign up free -> Settings -> API Keys -> Create Key
//  FREE PLAN: 60 credits/day (~6 videos of 5s each per day)
// ================================================================

class VideoGeneratorService {
  // PIXVERSE API KEY -- replace this
  static const String _pixverseApiKey = 'sk-c1c693c7682bc50e9dd874f4a6434144';

  // CLOUDINARY (unchanged)
  static const String cloudinaryCloudName = 'dli0cf2x3';
  static const String cloudinaryUploadPreset = 'nexora_unsigned';

  static const String _uploadImageUrl =
      'https://app-api.pixverse.ai/openapi/v2/image/upload';
  static const String _generateVideoUrl =
      'https://app-api.pixverse.ai/openapi/v2/video/img/generate';
  static const String _videoStatusUrl =
      'https://app-api.pixverse.ai/openapi/v2/video/result';

  static int _successCount = 0;
  static int _failedCount = 0;
  static int _totalAttempts = 0;

  // -----------------------------------------------
  //  MAIN: Generate Video from Image URL
  //  prompt: optional — will use a smart default if empty
  // -----------------------------------------------
  Future<String> generateImageToVideo(
      String imageUrl,
      String title, {
        String prompt = '',
      }) async {
    try {
      _totalAttempts++;
      print('[VIDEO] Starting: $title');
      print('   Source: $imageUrl');

      final imageBytes = await _downloadImage(imageUrl);
      if (imageBytes == null) { _failedCount++; return ''; }

      final imgId = await _uploadImageToPixverse(imageBytes, title);
      if (imgId == null) { _failedCount++; return ''; }

      final videoId = await _startVideoGeneration(imgId, title, prompt: prompt);
      if (videoId == null) { _failedCount++; return ''; }

      final pixverseUrl = await _pollVideoResult(videoId);
      if (pixverseUrl == null) { _failedCount++; return ''; }

      final videoBytes = await _downloadVideoBytes(pixverseUrl);
      if (videoBytes == null) { _failedCount++; return ''; }

      final cloudinaryUrl = await _uploadToCloudinary(videoBytes, title);
      if (cloudinaryUrl.isEmpty) { _failedCount++; return ''; }

      _successCount++;
      print('   [DONE] $cloudinaryUrl');
      return cloudinaryUrl;
    } catch (e) {
      _failedCount++;
      print('   [ERROR] $e');
      return '';
    }
  }

  // -----------------------------------------------
  //  Text-to-Video (also supported free!)
  // -----------------------------------------------
  Future<String> generateTextToVideo(String prompt, String title) async {
    try {
      _totalAttempts++;
      print('[TEXT->VIDEO] Starting: $title');

      final videoId = await _startTextVideoGeneration(prompt, title);
      if (videoId == null) { _failedCount++; return ''; }

      final pixverseUrl = await _pollVideoResult(videoId);
      if (pixverseUrl == null) { _failedCount++; return ''; }

      final videoBytes = await _downloadVideoBytes(pixverseUrl);
      if (videoBytes == null) { _failedCount++; return ''; }

      final cloudinaryUrl = await _uploadToCloudinary(videoBytes, title);
      if (cloudinaryUrl.isEmpty) { _failedCount++; return ''; }

      _successCount++;
      print('   [DONE] $cloudinaryUrl');
      return cloudinaryUrl;
    } catch (e) {
      _failedCount++;
      print('   [ERROR] $e');
      return '';
    }
  }

  // -----------------------------------------------
  //  STEP 1: Download Source Image
  // -----------------------------------------------
  Future<Uint8List?> _downloadImage(String imageUrl) async {
    try {
      print('   Downloading image...');
      final response = await http
          .get(Uri.parse(imageUrl))
          .timeout(const Duration(seconds: 60));
      if (response.statusCode == 200) {
        print('   Downloaded: ${response.bodyBytes.length} bytes');
        return response.bodyBytes;
      }
      print('   Download failed: ${response.statusCode}');
      return null;
    } catch (e) {
      print('   Download error: $e');
      return null;
    }
  }

  // -----------------------------------------------
  //  STEP 2: Upload Image to PixVerse -> get img_id
  // -----------------------------------------------
  Future<int?> _uploadImageToPixverse(
      Uint8List imageBytes, String title) async {
    try {
      print('   Uploading to PixVerse...');
      final request =
      http.MultipartRequest('POST', Uri.parse(_uploadImageUrl));
      request.headers['API-KEY'] = _pixverseApiKey;
      request.headers['Ai-trace-id'] = _traceId();
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: '${_clean(title)}.jpg',
      ));

      final response = await http.Response.fromStream(
        await request.send().timeout(const Duration(seconds: 60)),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['ErrCode'] == 0) {
          final id = data['Resp']['img_id'];
          print('   img_id: $id');
          return id;
        }
        print('   PixVerse error: ${data['ErrMsg']}');
      } else {
        print('   HTTP ${response.statusCode}: ${response.body}');
      }
      return null;
    } catch (e) {
      print('   Upload exception: $e');
      return null;
    }
  }

  // -----------------------------------------------
  //  STEP 3a: Image -> Video (with required prompt)
  // -----------------------------------------------
  Future<int?> _startVideoGeneration(
      int imgId,
      String title, {
        String prompt = '',
      }) async {
    try {
      print('   Starting image->video generation...');

      // PixVerse REQUIRES a non-empty prompt field
      final effectivePrompt = prompt.isNotEmpty
          ? prompt
          : 'Animate this image with smooth natural cinematic motion';
      print('   Prompt: $effectivePrompt');

      final response = await http
          .post(
        Uri.parse(_generateVideoUrl),
        headers: {
          'API-KEY': _pixverseApiKey,
          'Ai-trace-id': _traceId(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'img_id': imgId,
          'prompt': effectivePrompt,   // <-- REQUIRED by PixVerse
          'model': 'v5.6',
          'duration': 5,
          'motion_mode': 'normal',
          'quality': '720p',
          'water_mark': false,
        }),
      )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['ErrCode'] == 0) {
          final id = data['Resp']['video_id'];
          print('   video_id: $id');
          return id;
        }
        print('   Error: ${data['ErrMsg']}');
      } else {
        print('   HTTP ${response.statusCode}: ${response.body}');
      }
      return null;
    } catch (e) {
      print('   Exception: $e');
      return null;
    }
  }

  // -----------------------------------------------
  //  STEP 3b: Text -> Video
  // -----------------------------------------------
  Future<int?> _startTextVideoGeneration(
      String prompt, String title) async {
    try {
      print('   Starting text->video generation...');
      final response = await http
          .post(
        Uri.parse(
            'https://app-api.pixverse.ai/openapi/v2/video/text/generate'),
        headers: {
          'API-KEY': _pixverseApiKey,
          'Ai-trace-id': _traceId(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'prompt': prompt,
          'model': 'v5.6',
          'duration': 5,
          'quality': '720p',
          'water_mark': false,
        }),
      )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['ErrCode'] == 0) {
          final id = data['Resp']['video_id'];
          print('   video_id: $id');
          return id;
        }
        print('   Error: ${data['ErrMsg']}');
      }
      return null;
    } catch (e) {
      print('   Exception: $e');
      return null;
    }
  }

  // -----------------------------------------------
  //  STEP 4: Poll for result
  //  status: 1=pending  2=processing  3=done  4=failed
  // -----------------------------------------------
  Future<String?> _pollVideoResult(int videoId,
      {int maxAttempts = 30}) async {
    print('   Polling for result (max ~5 mins)...');
    for (int i = 0; i < maxAttempts; i++) {
      await Future.delayed(const Duration(seconds: 10));
      try {
        final response = await http
            .get(
          Uri.parse('$_videoStatusUrl/$videoId'),
          headers: {
            'API-KEY': _pixverseApiKey,
            'Ai-trace-id': _traceId(),
          },
        )
            .timeout(const Duration(seconds: 30));

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['ErrCode'] == 0) {
            final status = data['Resp']['status'];
            print('   status=$status (${i + 1}/$maxAttempts)');
            if (status == 3) {
              print('   Video ready!');
              return data['Resp']['url'];
            }
            if (status == 4) {
              print('   Failed on PixVerse side');
              return null;
            }
          }
        }
      } catch (e) {
        print('   Poll error (will retry): $e');
      }
    }
    print('   Timed out waiting for video');
    return null;
  }

  // -----------------------------------------------
  //  STEP 5: Download Video Bytes
  // -----------------------------------------------
  Future<Uint8List?> _downloadVideoBytes(String videoUrl) async {
    try {
      print('   Downloading video...');
      final response = await http
          .get(Uri.parse(videoUrl))
          .timeout(const Duration(minutes: 3));
      if (response.statusCode == 200) {
        print('   Video bytes: ${response.bodyBytes.length}');
        return response.bodyBytes;
      }
      return null;
    } catch (e) {
      print('   Video download error: $e');
      return null;
    }
  }

  // -----------------------------------------------
  //  STEP 6: Upload to Cloudinary
  // -----------------------------------------------
  Future<String> _uploadToCloudinary(
      Uint8List videoBytes, String title) async {
    for (int attempt = 1; attempt <= 3; attempt++) {
      try {
        print('   Cloudinary upload (attempt $attempt/3)...');
        final request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://api.cloudinary.com/v1_1/$cloudinaryCloudName/video/upload'),
        );
        request.files.add(http.MultipartFile.fromBytes(
          'file',
          videoBytes,
          filename: '${_clean(title)}.mp4',
        ));
        request.fields['upload_preset'] = cloudinaryUploadPreset;
        request.fields['folder'] = 'nexora_videos';
        request.fields['public_id'] = _clean(title);

        final response = await http.Response.fromStream(
          await request.send().timeout(const Duration(minutes: 5)),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final url = jsonDecode(response.body)['secure_url'];
          print('   Cloudinary URL: $url');
          return url;
        }
        print('   Cloudinary error: ${response.statusCode}');
        if (attempt < 3) await Future.delayed(const Duration(seconds: 10));
      } catch (e) {
        print('   Cloudinary exception: $e');
        if (attempt < 3) await Future.delayed(const Duration(seconds: 10));
      }
    }
    print('   Cloudinary failed after 3 attempts');
    return '';
  }

  // -----------------------------------------------
  //  HELPERS
  // -----------------------------------------------
  String _clean(String title) => title
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]'), '_')
      .replaceAll(RegExp(r'_+'), '_')
      .replaceAll(RegExp(r'^_|_$'), '');

  String _traceId() =>
      'nexora-${DateTime.now().millisecondsSinceEpoch.toRadixString(16)}';

  static void printStats() {
    print('');
    print('VIDEO GENERATION STATS (PixVerse -- FREE 60 credits/day)');
    print('Total attempts : $_totalAttempts');
    print('Successful     : $_successCount');
    print('Failed         : $_failedCount');
    print('Cost           : \$0.00 (FREE!)');
    final rate = _totalAttempts > 0
        ? (_successCount / _totalAttempts * 100).toStringAsFixed(1)
        : '0';
    print('Success rate   : $rate%');
  }

  static void resetStats() {
    _successCount = 0;
    _failedCount = 0;
    _totalAttempts = 0;
  }
}