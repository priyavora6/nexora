// lib/scripts/remove_videos_from_json.dart
import 'dart:convert';
import 'dart:io';

void main() async {
  print('═══════════════════════════════════════════════════════════');
  print('🧹 CLEANUP: REMOVING VIDEO ENTRIES FROM JSON');
  print('═══════════════════════════════════════════════════════════\n');

  // 1. Identify your progress file
  // Change this to 'generated_media.json' if that is your filename
  final jsonFile = File('generated_images.json');

  if (!await jsonFile.exists()) {
    print('❌ Error: JSON file not found!');
    return;
  }

  // 2. Read and Parse JSON
  final content = await jsonFile.readAsString();
  Map<String, dynamic> data = {};

  try {
    data = Map<String, dynamic>.from(jsonDecode(content));
  } catch (e) {
    print('❌ Error parsing JSON: $e');
    return;
  }

  print('📊 Total entries before cleaning: ${data.length}');

  // 3. Define the cleaning logic
  int removedCount = 0;
  final Map<String, dynamic> cleanedData = {};

  data.forEach((title, details) {
    bool isVideo = false;

    // Logic A: Check for video specific keys
    if (details.containsKey('cloudinaryVideoUrl') ||
        details.containsKey('videoUrl') ||
        details.containsKey('isVideo')) {
      if (details['isVideo'] == true || details['cloudinaryVideoUrl'] != null) {
        isVideo = true;
      }
    }

    // Logic B: Check for file extensions in filename or URL
    final String filename = (details['filename'] ?? '').toString().toLowerCase();
    final String url = (details['cloudinaryUrl'] ?? '').toString().toLowerCase();

    if (filename.endsWith('.mp4') || url.endsWith('.mp4') || filename.contains('_video')) {
      isVideo = true;
    }

    // Logic C: Check if category or title mentions video
    final String category = (details['category'] ?? '').toString().toLowerCase();
    if (category.contains('video') || category.contains('animation')) {
      isVideo = true;
    }

    if (isVideo) {
      removedCount++;
      print('   🗑️ Removing: $title');
    } else {
      // It's a valid image, keep it
      cleanedData[title] = details;
    }
  });

  // 4. Save the cleaned file
  if (removedCount > 0) {
    // Create a backup first just in case
    final backupFile = File('backup_before_video_removal.json');
    await backupFile.writeAsString(content);

    // Save cleaned data
    await jsonFile.writeAsString(JsonEncoder.withIndent('  ').convert(cleanedData));

    print('\n═══════════════════════════════════════════════════════════');
    print('✅ CLEANUP COMPLETE');
    print('═══════════════════════════════════════════════════════════');
    print('🗑️  Entries Removed: $removedCount');
    print('🖼️  Entries Remaining: ${cleanedData.length}');
    print('💾 Backup saved as: backup_before_video_removal.json');
    print('═══════════════════════════════════════════════════════════');
  } else {
    print('\n✨ No video entries were found. JSON is already clean!');
  }
}