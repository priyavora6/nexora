import 'dart:convert';
import 'dart:io';
import '../data/prompt_library.dart';

void main() async {
  final jsonFile = File('generated_images.json');
  if (!await jsonFile.exists()) {
    print('❌ No generated_images.json found!');
    return;
  }

  // 1. Load your actual code library (The source of truth)
  final libraryPrompts = PromptLibrary.getAllPrompts();
  final Set<String> validTitles = libraryPrompts.map((p) => p['title'].toString()).toSet();

  // 2. Load your messy JSON
  final String content = await jsonFile.readAsString();
  final Map<String, dynamic> existingJson = jsonDecode(content);

  print('📊 CURRENT STATS:');
  print('   - Prompts in Code: ${validTitles.length}');
  print('   - Entries in JSON: ${existingJson.length}');

  // 3. PRUNE: Remove entries from JSON that no longer exist in Code
  Map<String, dynamic> cleanedJson = {};
  Set<String> activeCloudinaryUrls = {};

  for (var title in validTitles) {
    if (existingJson.containsKey(title)) {
      cleanedJson[title] = existingJson[title];
      activeCloudinaryUrls.add(existingJson[title]['cloudinaryUrl']);
    }
  }

  // 4. SAVE the cleaned JSON
  await jsonFile.writeAsString(JsonEncoder.withIndent('  ').convert(cleanedJson));

  print('\n✅ JSON CLEANED!');
  print('   - New JSON Count: ${cleanedJson.length} / ${validTitles.length}');
  print('   - Removed ${existingJson.length - cleanedJson.length} ghost entries from JSON.');

  // 5. CLOUDINARY CLEANUP LIST
  print('\n☁️ CLOUDINARY SYNC INFO:');
  print('   - Images needed by App: ${activeCloudinaryUrls.length}');
  print('   - Total images in Cloudinary: 1,233 (based on your screenshot)');
  print('   - 🗑️ TRASH IMAGES TO DELETE: ${1233 - activeCloudinaryUrls.length}');

  print('\n💡 ACTION: Run "dart lib/scripts/batch_image_generator.dart" now.');
  print('   It will only generate the ${validTitles.length - cleanedJson.length} missing images.');
}