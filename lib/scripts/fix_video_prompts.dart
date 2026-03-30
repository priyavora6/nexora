// lib/scripts/fix_video_prompts.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart'; // Add to pubspec: crypto: ^3.0.3
import '../data/prompt_library.dart';

// ─────────────────────────────────────────
// ☁️ CLOUDINARY CREDENTIALS (for deletion)
// ─────────────────────────────────────────
const String cloudinaryCloudName = 'dli0cf2x3';
const String cloudinaryApiKey = '345465847414751';       // 👈 Dashboard se lo
const String cloudinaryApiSecret = 'vy2ZNy9aU3r8sCgfpO5yfiIvxAQ'; // 👈 Dashboard se lo

void main() async {
  print('═══════════════════════════════════════════════════════════');
  print('🔧 FIX VIDEO PROMPTS - DETECT, DELETE & CLEAN');
  print('═══════════════════════════════════════════════════════════\n');

  // ─────────────────────────────────────────
  // STEP 1: Load Master Library
  // ─────────────────────────────────────────
  final allPrompts = PromptLibrary.getAllPrompts();
  final Map<String, Map<String, dynamic>> masterMap = {
    for (var p in allPrompts) (p['title'] as String): Map<String, dynamic>.from(p)
  };
  print('📚 Master Library: ${allPrompts.length} total prompts\n');

  // ─────────────────────────────────────────
  // STEP 2: Show all categories for selection
  // ─────────────────────────────────────────
  Map<String, int> categoryCounts = {};
  for (var p in allPrompts) {
    final cat = p['category']?.toString() ?? 'Unknown';
    categoryCounts[cat] = (categoryCounts[cat] ?? 0) + 1;
  }

  print('📂 ALL CATEGORIES:');
  print('───────────────────────────────────────────────────────────');

  Map<int, String> categoryIndexMap = {};
  int idx = 1;
  for (var entry in categoryCounts.entries) {
    categoryIndexMap[idx] = entry.key;

    // Auto-detect video keywords
    final isLikelyVideo = _isLikelyVideoCategory(entry.key);
    final marker = isLikelyVideo ? ' 🎥 LIKELY VIDEO' : '';

    print('   [$idx] ${entry.key} (${entry.value} prompts)$marker');
    idx++;
  }

  // ─────────────────────────────────────────
  // STEP 3: User selects VIDEO categories
  // ─────────────────────────────────────────
  print('\n───────────────────────────────────────────────────────────');
  print('⚠️  SELECT WHICH CATEGORIES ARE VIDEO PROMPTS');
  print('───────────────────────────────────────────────────────────');
  stdout.write('\n🎥 Enter category NUMBERS for VIDEOS (comma separated): ');
  stdout.write('\n   Example: 3,5,12\n\n   Your selection: ');

  final input = stdin.readLineSync() ?? '';
  final selectedNums = input
      .split(',')
      .map((s) => int.tryParse(s.trim()))
      .whereType<int>()
      .toList();

  if (selectedNums.isEmpty) {
    print('❌ No categories selected. Exiting.');
    return;
  }

  // Get selected video category names
  Set<String> videoCategories = {};
  for (var num in selectedNums) {
    if (categoryIndexMap.containsKey(num)) {
      videoCategories.add(categoryIndexMap[num]!);
    }
  }

  print('\n✅ VIDEO CATEGORIES SELECTED:');
  for (var cat in videoCategories) {
    print('   🎬 $cat (${categoryCounts[cat]} prompts)');
  }

  // ─────────────────────────────────────────
  // STEP 4: Separate video and image prompts
  // ─────────────────────────────────────────
  Set<String> videoTitles = {};
  for (var p in allPrompts) {
    final cat = p['category']?.toString() ?? '';
    if (videoCategories.contains(cat)) {
      videoTitles.add(p['title'] as String);
    }
  }

  print('\n📊 Found ${videoTitles.length} VIDEO prompts to fix');

  // ─────────────────────────────────────────
  // STEP 5: Load progress JSON
  // ─────────────────────────────────────────
  final progressFile = File('generated_images.json');
  if (!await progressFile.exists()) {
    print('❌ generated_images.json not found!');
    return;
  }

  Map<String, dynamic> progressData = {};
  try {
    final decoded = jsonDecode(await progressFile.readAsString());
    if (decoded is Map) {
      progressData = Map<String, dynamic>.from(decoded);
    }
  } catch (e) {
    print('❌ JSON parse error: $e');
    return;
  }

  print('💾 Progress JSON has: ${progressData.length} entries\n');

  // ─────────────────────────────────────────
  // STEP 6: Find wrongly generated images
  // ─────────────────────────────────────────
  List<Map<String, String>> wronglyGeneratedImages = [];
  Map<String, dynamic> cleanedProgressData = {};
  int alreadyMissing = 0;

  for (var entry in progressData.entries) {
    final title = entry.key;
    final data = entry.value;

    if (videoTitles.contains(title)) {
      // This is a VIDEO prompt but was generated as IMAGE
      final cloudinaryUrl = data['cloudinaryUrl']?.toString() ?? '';

      if (cloudinaryUrl.isNotEmpty) {
        // Extract public_id from Cloudinary URL for deletion
        final publicId = _extractPublicId(cloudinaryUrl);
        wronglyGeneratedImages.add({
          'title': title,
          'url': cloudinaryUrl,
          'publicId': publicId,
        });
      } else {
        alreadyMissing++;
      }
      // DO NOT add to cleaned data - we want to remove these
    } else {
      // This is a legitimate IMAGE prompt, keep it
      cleanedProgressData[title] = data;
    }
  }

  // ─────────────────────────────────────────
  // STEP 7: Show what will be deleted
  // ─────────────────────────────────────────
  print('═══════════════════════════════════════════════════════════');
  print('🗑️  DELETION PLAN');
  print('═══════════════════════════════════════════════════════════');
  print('🖼️  Images to DELETE from Cloudinary: ${wronglyGeneratedImages.length}');
  print('📝 Entries to REMOVE from JSON:       ${wronglyGeneratedImages.length + alreadyMissing}');
  print('✅ Entries to KEEP (valid images):     ${cleanedProgressData.length}');
  print('───────────────────────────────────────────────────────────');

  if (wronglyGeneratedImages.isNotEmpty) {
    print('\n🗑️  IMAGES THAT WILL BE DELETED:');
    for (int i = 0; i < wronglyGeneratedImages.length && i < 15; i++) {
      print('   ❌ ${wronglyGeneratedImages[i]['title']}');
      print('      URL: ${wronglyGeneratedImages[i]['url']}');
    }
    if (wronglyGeneratedImages.length > 15) {
      print('   ... and ${wronglyGeneratedImages.length - 15} more');
    }
  }

  // ─────────────────────────────────────────
  // STEP 8: Confirm and execute
  // ─────────────────────────────────────────
  print('\n═══════════════════════════════════════════════════════════');
  print('⚠️  THIS WILL:');
  print('   1. DELETE ${wronglyGeneratedImages.length} images from Cloudinary');
  print('   2. REMOVE ${wronglyGeneratedImages.length + alreadyMissing} entries from progress JSON');
  print('   3. CREATE video_todo.json with ${videoTitles.length} video prompts');
  print('═══════════════════════════════════════════════════════════');

  stdout.write('\n⚠️  ARE YOU SURE? Type "DELETE" to confirm: ');
  final confirm = stdin.readLineSync()?.trim();

  if (confirm != 'DELETE') {
    print('\n❌ Aborted. Nothing was changed.');
    return;
  }

  // ─────────────────────────────────────────
  // STEP 9: DELETE from Cloudinary
  // ─────────────────────────────────────────
  print('\n🗑️  Deleting images from Cloudinary...');
  int deleteSuccess = 0;
  int deleteFailed = 0;

  for (var item in wronglyGeneratedImages) {
    final publicId = item['publicId']!;
    final title = item['title']!;

    try {
      final deleted = await _deleteFromCloudinary(publicId);
      if (deleted) {
        deleteSuccess++;
        print('   ✅ Deleted: $title');
      } else {
        deleteFailed++;
        print('   ⚠️  Failed to delete: $title');
      }
    } catch (e) {
      deleteFailed++;
      print('   ❌ Error deleting $title: $e');
    }

    // Small delay to avoid rate limiting
    await Future.delayed(const Duration(milliseconds: 300));
  }

  // ─────────────────────────────────────────
  // STEP 10: Clean progress JSON
  // ─────────────────────────────────────────
  print('\n📝 Cleaning progress JSON...');

  // Backup the original file first
  final backupFile = File('generated_images_backup_${DateTime.now().millisecondsSinceEpoch}.json');
  await backupFile.writeAsString(await progressFile.readAsString());
  print('   💾 Backup saved: ${backupFile.path}');

  // Write cleaned data
  await progressFile.writeAsString(
      JsonEncoder.withIndent('  ').convert(cleanedProgressData));
  print('   ✅ Progress JSON cleaned. ${cleanedProgressData.length} entries remain.');

  // ─────────────────────────────────────────
  // STEP 11: Create video to-do list
  // ─────────────────────────────────────────
  print('\n🎥 Creating video to-do list...');

  List<Map<String, dynamic>> videoTodoList = [];
  for (var title in videoTitles) {
    final promptData = masterMap[title];
    if (promptData != null) {
      videoTodoList.add({
        "title": title,
        "filename": _sanitize(title, isVideo: true),
        "text": promptData['text'],
        "category": promptData['category'],
        "platform": promptData['platform'] ?? '',
        "isVideo": true,
        "status": "pending",
      });
    }
  }

  await File('videos_to_generate.json').writeAsString(
      JsonEncoder.withIndent('  ').convert(videoTodoList));

  // Also create updated image to-do list
  List<Map<String, dynamic>> imageTodoList = [];
  for (var p in allPrompts) {
    final title = p['title'] as String;
    if (!videoTitles.contains(title) && !cleanedProgressData.containsKey(title)) {
      imageTodoList.add({
        "title": title,
        "filename": _sanitize(title, isVideo: false),
        "text": p['text'],
        "category": p['category'],
        "platform": p['platform'] ?? '',
        "isVideo": false,
        "status": "pending",
      });
    }
  }

  await File('images_to_generate.json').writeAsString(
      JsonEncoder.withIndent('  ').convert(imageTodoList));

  // Save video titles reference for future use
  await File('video_titles_reference.json').writeAsString(
      JsonEncoder.withIndent('  ').convert(videoTitles.toList()));

  // ─────────────────────────────────────────
  // FINAL REPORT
  // ─────────────────────────────────────────
  print('\n═══════════════════════════════════════════════════════════');
  print('✅ OPERATION COMPLETE!');
  print('═══════════════════════════════════════════════════════════');
  print('🗑️  Cloudinary Deletions:');
  print('   ✅ Successful: $deleteSuccess');
  print('   ❌ Failed:     $deleteFailed');
  print('');
  print('📝 Progress JSON:');
  print('   Before: ${progressData.length} entries');
  print('   After:  ${cleanedProgressData.length} entries');
  print('   Removed: ${progressData.length - cleanedProgressData.length} entries');
  print('');
  print('📂 Files Created:');
  print('   🎥 videos_to_generate.json   (${videoTodoList.length} videos)');
  print('   📷 images_to_generate.json   (${imageTodoList.length} images)');
  print('   📋 video_titles_reference.json');
  print('   💾 ${backupFile.path} (backup)');
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('📊 REMAINING WORK:');
  print('   📷 Images to generate: ${imageTodoList.length}');
  print('   🎥 Videos to generate: ${videoTodoList.length}');
  print('   📦 Total remaining:    ${imageTodoList.length + videoTodoList.length}');
  print('═══════════════════════════════════════════════════════════');
}

// ─────────────────────────────────────────
// 🔍 Auto-detect video category keywords
// ─────────────────────────────────────────
bool _isLikelyVideoCategory(String category) {
  final lower = category.toLowerCase();
  final videoKeywords = [
    'video', 'animation', 'animate', 'motion',
    'reel', 'cinematic', 'clip', 'film',
    'runway', 'pika', 'kling', 'luma',
    'image-to-video', 'img2vid', 'i2v',
    'text-to-video', 't2v', 'dynamic',
  ];
  return videoKeywords.any((k) => lower.contains(k));
}

// ─────────────────────────────────────────
// 🔗 Extract public_id from Cloudinary URL
// ─────────────────────────────────────────
String _extractPublicId(String url) {
  try {
    // Cloudinary URL format:
    // https://res.cloudinary.com/cloud_name/image/upload/v123/folder/public_id.ext
    final uri = Uri.parse(url);
    final pathSegments = uri.pathSegments;

    // Find the index after "upload"
    final uploadIndex = pathSegments.indexOf('upload');
    if (uploadIndex == -1) return '';

    // Everything after "upload" and version number is the public_id
    int startIndex = uploadIndex + 1;

    // Skip version number (v followed by digits)
    if (startIndex < pathSegments.length &&
        pathSegments[startIndex].startsWith('v') &&
        int.tryParse(pathSegments[startIndex].substring(1)) != null) {
      startIndex++;
    }

    // Join remaining segments and remove extension
    final publicIdWithExt = pathSegments.sublist(startIndex).join('/');
    final lastDot = publicIdWithExt.lastIndexOf('.');
    if (lastDot != -1) {
      return publicIdWithExt.substring(0, lastDot);
    }
    return publicIdWithExt;
  } catch (e) {
    print('   ⚠️  Could not extract public_id from: $url');
    return '';
  }
}

// ─────────────────────────────────────────
// 🗑️ Delete image from Cloudinary
// ─────────────────────────────────────────
Future<bool> _deleteFromCloudinary(String publicId) async {
  if (publicId.isEmpty) return false;

  try {
    final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    // Create signature for authenticated API call
    final signatureString = 'public_id=$publicId&timestamp=$timestamp$cloudinaryApiSecret';
    final signature = sha1.convert(utf8.encode(signatureString)).toString();

    final response = await http.post(
      Uri.parse('https://api.cloudinary.com/v1_1/$cloudinaryCloudName/image/destroy'),
      body: {
        'public_id': publicId,
        'api_key': cloudinaryApiKey,
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
    return false;
  }
}

// ─────────────────────────────────────────
// 🧹 Sanitize filename
// ─────────────────────────────────────────
String _sanitize(String title, {bool isVideo = false}) {
  final ext = isVideo ? '.mp4' : '.jpg';
  return title
      .toLowerCase()
      .replaceAll(' ', '_')
      .replaceAll(RegExp(r'[\\/:*?"<>|]'), '')
      + ext;
}