import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../data/prompt_library.dart'; // 👈 Master library import zaruri hai

// -----------------------------------------------------------------------------
//  IMPORTANT: This script assumes you have added `isVideo: true` to the prompts
//  in your `prompt_library.dart` that require video generation.
// -----------------------------------------------------------------------------

void main() async {
  print('═══════════════════════════════════════════════════════════');
  print('🔄 SYNCING IMAGE & VIDEO PROGRESS WITH MASTER LIBRARY');
  print('═══════════════════════════════════════════════════════════\n');

  // 1. Load Master Library
  final allPrompts = PromptLibrary.getAllPrompts();
  print('📚 Master Library has: ${allPrompts.length} total prompts');

  // 2. Load current progress JSON
  final progressFile = File('generated_images.json'); // Main progress file
  Map<String, dynamic> progressData = {};
  if (await progressFile.exists()) {
    final content = await progressFile.readAsString();
    try {
      progressData = Map<String, dynamic>.from(jsonDecode(content));
    } catch (e) {
      print('❌ JSON parse error in ${progressFile.path}: $e');
      return;
    }
  } else {
    print('ℹ️  ${progressFile.path} not found. Will be created if you proceed.');
  }
  print('💾 Progress file has: ${progressData.length} entries\n');

  // 3. Initialize counters and to-do lists
  int validImages = 0;
  int validVideos = 0;
  List<Map<String, dynamic>> imagesToGenerate = [];
  List<Map<String, dynamic>> videosToGenerate = [];
  Map<String, dynamic> cleanedData = {};

  int totalImageTasks = 0;
  int totalVideoTasks = 0;

  print('🔍 Verifying Cloudinary links for all ${allPrompts.length} master prompts...');

  // 4. Iterate through the MASTER list, which is the source of truth
  for (var prompt in allPrompts) {
    final title = prompt['title'] as String;
    final bool isVideoTask = prompt['isVideo'] == true;

    // Count total tasks of each type
    if (isVideoTask) {
      totalVideoTasks++;
    } else {
      totalImageTasks++;
    }

    final entry = progressData[title];
    bool isTaskComplete = false;
    String? urlToCheck;

    if (entry != null) {
      // Determine which URL to check based on the task type
      urlToCheck = isVideoTask
          ? entry['cloudinaryVideoUrl']?.toString()
          : entry['cloudinaryUrl']?.toString();

      // Fallback for older entries where video might be in cloudinaryUrl
      if (isVideoTask && (urlToCheck == null || urlToCheck.isEmpty)) {
        urlToCheck = entry['cloudinaryUrl']?.toString();
      }
    }

    // If a URL exists, verify it
    if (urlToCheck != null && urlToCheck.isNotEmpty) {
      try {
        final response = await http.head(Uri.parse(urlToCheck)).timeout(const Duration(seconds: 5));
        if (response.statusCode == 200) {
          isTaskComplete = true;
        } else {
          print('   ❌ Dead link for [$title]: ${response.statusCode}');
        }
      } catch (e) {
        // Network error, task is not considered complete
        isTaskComplete = false;
        print('   ⚠️ Error checking [$title]: $e');
      }
    }

    // 5. Categorize the prompt based on its completion status
    if (isTaskComplete) {
      cleanedData[title] = entry; // Keep the valid entry
      if (isVideoTask) {
        validVideos++;
      } else {
        validImages++;
      }
    } else {
      // Task is NOT complete, add it to the appropriate to-do list
      final taskDetails = {
        "filename": _sanitizeTitleForFilename(title, isVideo: isVideoTask),
        "text": prompt['text'],
        "category": prompt['category'] ?? 'General',
        "title": title,
      };
      if (isVideoTask) {
        videosToGenerate.add(taskDetails);
      } else {
        imagesToGenerate.add(taskDetails);
      }
    }
  }

  // 6. THE FINAL REPORT
  final imagesRemaining = imagesToGenerate.length;
  final videosRemaining = videosToGenerate.length;

  print('\n═══════════════════════════════════════════════════════════');
  print('📊 FINAL SYNC REPORT');
  print('═══════════════════════════════════════════════════════════');
  print('📷 IMAGE GENERATION');
  print('   - Completed:   $validImages / $totalImageTasks');
  print('   - REMAINING:   $imagesRemaining');
  print('───────────────────────────────────────────────────────────');
  print('🎥 VIDEO GENERATION');
  print('   - Completed:   $validVideos / $totalVideoTasks');
  print('   - REMAINING:   $videosRemaining');
  print('───────────────────────────────────────────────────────────');
  final totalComplete = validImages + validVideos;
  final totalItems = allPrompts.length;
  final percentage = totalItems > 0 ? (totalComplete / totalItems * 100) : 0;
  print('📈 OVERALL PROGRESS:    $totalComplete / $totalItems (${percentage.toStringAsFixed(1)}%)');
  print('═══════════════════════════════════════════════════════════');

  // 7. Action
  final totalWorkCount = imagesRemaining + videosRemaining;
  if (totalWorkCount == 0) {
    print('\n🎉 Everything is up to date! No action needed.');
    return;
  }

  stdout.write('\n🔧 Found $totalWorkCount items to process. Create to-do files? (y/n): ');
  final confirm = stdin.readLineSync()?.toLowerCase();

  if (confirm == 'y' || confirm == 'yes') {
    // Save the cleaned progress file
    await progressFile.writeAsString(JsonEncoder.withIndent('  ').convert(cleanedData));
    print('\n   ✅ Progress file cleaned. Saved to ${progressFile.path}');

    // Save separate to-do lists
    if (imagesToGenerate.isNotEmpty) {
      await File('images_to_generate.json').writeAsString(JsonEncoder.withIndent('  ').convert(imagesToGenerate));
      print('   💾 Image to-do list saved to: images_to_generate.json');
    }
    if (videosToGenerate.isNotEmpty) {
      await File('videos_to_generate.json').writeAsString(JsonEncoder.withIndent('  ').convert(videosToGenerate));
      print('   💾 Video to-do list saved to: videos_to_generate.json');
    }
    print('\n🚀 Ready for generation!');
  } else {
    print('\nAborted. No files were changed.');
  }
}

/// Helper function to convert a prompt title into a safe filename with the correct extension.
String _sanitizeTitleForFilename(String title, {bool isVideo = false}) {
  final extension = isVideo ? '.mp4' : '.jpg';
  return title
      .toLowerCase()
      .replaceAll(' ', '_') // Replace spaces with underscores
      .replaceAll(RegExp(r'[\\/:*?"<>|]'), '') // Remove invalid characters
      + extension;
}
