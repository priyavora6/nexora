import 'dart:convert';
import 'dart:io';
import '../services/video_generator_service.dart';

class BatchVideoGenerator {
  final VideoGeneratorService _videoGen = VideoGeneratorService();

  Future<void> generateAllVideos() async {
    print('═══════════════════════════════════════════════════════════');
    print('🎬 AI VIDEO BATCH GENERATOR (TEST MODE: FIRST 20 PROMPTS)');
    print('═══════════════════════════════════════════════════════════\n');

    // 1. Load Image Data
    final imageFile = File('generated_images.json');
    if (!await imageFile.exists()) {
      print('❌ Error: generated_images.json not found! Run image generator first.');
      return;
    }

    // ✅ FIX: Handle BOTH formats — plain List OR Map with nested list
    final List<dynamic> imagesData = _parseJsonFile(await imageFile.readAsString());

    if (imagesData.isEmpty) {
      print('❌ Could not parse generated_images.json — check its format.');
      return;
    }

    print('✅ Loaded ${imagesData.length} images from JSON.');

    // 2. Load existing videos (to resume)
    List<Map<String, dynamic>> videoResults = [];
    final videoFile = File('generated_videos.json');
    if (await videoFile.exists()) {
      final content = await videoFile.readAsString();
      if (content.isNotEmpty) {
        videoResults = _parseJsonFile(content)
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
        print('📦 Loaded ${videoResults.length} existing video records.');
      }
    }

    // 3. Take first 20 for test mode
    final videoPrompts = imagesData.take(20).toList();

    print('📊 Total images in JSON  : ${imagesData.length}');
    print('📊 Prompts for video test: ${videoPrompts.length}');

    if (videoPrompts.isEmpty) {
      print('⚠️ No images found to process.');
      return;
    }

    int currentRunSuccess = 0;

    for (int i = 0; i < videoPrompts.length; i++) {
      final prompt = Map<String, dynamic>.from(videoPrompts[i]);
      final title = prompt['title']?.toString() ?? 'untitled_$i';

      // SKIP if already done
      if (videoResults.any((v) => v['title'] == title)) {
        print('\n⏭️  [${i + 1}/${videoPrompts.length}] Skipping (already done): $title');
        continue;
      }

      print('\n🎥 [${i + 1}/${videoPrompts.length}] Processing: $title');
      print('   Category: ${prompt['category'] ?? 'unknown'}');

      try {
        String videoUrl = '';

        final cloudinaryUrl = prompt['cloudinaryUrl']?.toString() ?? '';

        if (cloudinaryUrl.isNotEmpty) {
          print('   🎞️  Animating existing image (Image-to-Video)...');
          videoUrl = await _videoGen.generateImageToVideo(cloudinaryUrl, title);
        } else {
          print('   📝 No image URL found, trying text-to-video...');
          videoUrl = await _videoGen.generateTextToVideo(
            prompt['text']?.toString() ?? title,
            title,
          );
        }

        if (videoUrl.isNotEmpty) {
          videoResults.add({
            'title': title,
            'videoUrl': videoUrl,
            'category': prompt['category'] ?? '',
            'generatedAt': DateTime.now().toIso8601String(),
          });

          currentRunSuccess++;

          // Save immediately after each success
          await videoFile.writeAsString(
            JsonEncoder.withIndent('  ').convert(videoResults),
          );
          print('   ✅ Video saved!');
        } else {
          print('   ⚠️ No video URL returned — skipping.');
        }

      } catch (e) {
        print('   ❌ Error: $e');
      }

      print('   ⏳ Waiting 10 seconds before next request...');
      await Future.delayed(const Duration(seconds: 10));
    }

    print('\n═══════════════════════════════════════════════════════════');
    print('🎉 DONE! Generated $currentRunSuccess new videos.');
    print('💾 Saved to: generated_videos.json');
    print('═══════════════════════════════════════════════════════════\n');

    VideoGeneratorService.printStats();
  }

  /// ✅ MAIN FIX: Safely parse JSON whether it's a List or a Map
  List<dynamic> _parseJsonFile(String content) {
    try {
      final decoded = jsonDecode(content);

      // Format 1: [ {...}, {...} ]  ← plain array
      if (decoded is List) {
        return decoded;
      }

      // Format 2: { "images": [ {...}, {...} ] }
      if (decoded is Map) {
        // Try common key names
        for (final key in ['images', 'data', 'items', 'results', 'prompts']) {
          if (decoded[key] is List) {
            print('      📦 JSON format detected: Map with "$key" key');
            return decoded[key] as List;
          }
        }

        // Last resort: return the map values as a list
        print('      ⚠️ Unknown Map format, trying values as list...');
        return decoded.values.whereType<Map>().toList();
      }

      print('      ❌ Unrecognized JSON format');
      return [];
    } catch (e) {
      print('      ❌ JSON parse error: $e');
      return [];
    }
  }
}