import 'dart:convert';
import 'dart:io';
import '../services/media_generator_service.dart';

/// This script reads 'images_to_generate.json' and generates/uploads them one by one.
void main() async {
  print('═══════════════════════════════════════════════════════════');
  print('🚀 BATCH GENERATOR: PROCESSING MISSING IMAGES');
  print('═══════════════════════════════════════════════════════════\n');

  final todoFile = File('images_to_generate.json');
  final progressFile = File('generated_images.json');
  final MediaGeneratorService mediaService = MediaGeneratorService();

  if (!await todoFile.exists()) {
    print('❌ Error: images_to_generate.json not found. Run sync_progress.dart first.');
    return;
  }

  // 1. Load To-Do list
  final List<dynamic> todoList = jsonDecode(await todoFile.readAsString());
  print('📊 Found ${todoList.length} images to generate.\n');

  // 2. Load existing progress to update it
  Map<String, dynamic> progressData = {};
  if (await progressFile.exists()) {
    progressData = Map<String, dynamic>.from(jsonDecode(await progressFile.readAsString()));
  }

  int successCount = 0;
  int failCount = 0;

  for (int i = 0; i < todoList.length; i++) {
    final item = todoList[i];
    final String title = item['title'];
    final String text = item['text'];
    final String category = item['category'];
    final String subcategory = item['subcategory'] ?? 'General';

    // SKIP if already in Progress (Safety check)
    if (progressData.containsKey(title)) {
      print('   ⏭️ Skipping (already exists): $title');
      continue;
    }

    print('[$i/${todoList.length}] 📸 Generating: $title');

    try {
      // 3. Generate Image via service
      final String url = await mediaService.generateImage(
        promptText: text,
        title: title,
        category: category,
      );

      if (url.isNotEmpty) {
        // 4. Update Progress Map
        progressData[title] = {
          "title": title,
          "category": category,
          "subcategory": subcategory,
          "platform": item['platform'] ?? 'Midjourney',
          "cloudinaryUrl": url,
          "videoUrl": "",
          "isFeatured": item['isFeatured']?.toString() ?? 'false',
        };

        // 5. Save progress immediately
        await progressFile.writeAsString(const JsonEncoder.withIndent('  ').convert(progressData));
        successCount++;
        print('   ✅ Success! Saved to progress JSON.');
      } else {
        failCount++;
        print('   ❌ Failed: Empty URL returned.');
      }
    } catch (e) {
      failCount++;
      print('   ❌ Error: $e');
    }

    // Delay to avoid rate limits
    await Future.delayed(const Duration(seconds: 3));
  }

  print('\n═══════════════════════════════════════════════════════════');
  print('🏁 BATCH RUN COMPLETE');
  print('   ✅ Success: $successCount');
  print('   ❌ Failed:  $failCount');
  print('═══════════════════════════════════════════════════════════');
}
