import 'dart:convert';
import 'dart:io';
import '../data/prompt_library.dart';

void main() async {
  print('🧹 CLEANUP: Syncing generated_images.json with Master Library...');

  // 1. Load Master Library
  final allPrompts = PromptLibrary.getAllPrompts();
  final Set<String> masterTitles = allPrompts.map((p) => p['title'] as String).toSet();
  print('📚 Master Library has: ${masterTitles.length} unique prompts');

  // 2. Load current progress JSON
  final progressFile = File('generated_images.json');
  if (!await progressFile.exists()) {
    print('❌ generated_images.json not found!');
    return;
  }

  final content = await progressFile.readAsString();
  final Map<String, dynamic> progressData = Map<String, dynamic>.from(jsonDecode(content));
  print('💾 Current progress file has: ${progressData.length} entries');

  // 3. Filter entries
  final Map<String, dynamic> cleanedData = {};
  int orphansRemoved = 0;

  progressData.forEach((title, data) {
    if (masterTitles.contains(title)) {
      cleanedData[title] = data;
    } else {
      orphansRemoved++;
    }
  });

  print('🗑️ Removing $orphansRemoved orphan entries (not in Master Library)...');

  // 4. Save cleaned file
  await progressFile.writeAsString(const JsonEncoder.withIndent('  ').convert(cleanedData));
  
  print('✅ DONE! New entry count: ${cleanedData.length}');
  print('🚀 generated_images.json is now perfectly synced with your code.');
}
