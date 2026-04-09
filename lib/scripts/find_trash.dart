// lib/scripts/find_trash.dart
import 'dart:convert';
import 'dart:io';
import '../data/prompt_library.dart';

void main() async {
  final jsonFile = File('generated_images.json');
  if (!await jsonFile.exists()) {
    print('❌ ERROR: generated_images.json file not found!');
    return;
  }

  // 1. Get the list of VALID prompts from your code
  final allPromptsFromCode = PromptLibrary.getAllPrompts();
  final Set<String> validTitles = allPromptsFromCode.map((p) => p['title'].toString()).toSet();

  // 2. Load your JSON file with the extra data
  final String jsonContent = await jsonFile.readAsString();
  final Map<String, dynamic> existingJsonData = jsonDecode(jsonContent);

  print('📊 AUDITING JSON FILE...');
  print('   - Prompts in Code Library: ${validTitles.length}');
  print('   - Entries in JSON file:    ${existingJsonData.length}');

  // 3. Create a NEW map, only adding entries that are still valid
  Map<String, dynamic> cleanedJson = {};
  int removedCount = 0;

  existingJsonData.forEach((title, data) {
    if (validTitles.contains(title)) {
      // This prompt is valid, so keep it
      cleanedJson[title] = data;
    } else {
      // This is a "ghost" prompt, so we ignore it
      print('   - 👻 Removing ghost entry: "$title"');
      removedCount++;
    }
  });

  // 4. Overwrite the old file with the clean data
  await jsonFile.writeAsString(JsonEncoder.withIndent('  ').convert(cleanedJson));

  print('\n✅ JSON CLEANED SUCCESSFULLY!');
  print('   - Removed $removedCount ghost entries.');
  print('   - New JSON Count: ${cleanedJson.length}');
  print('══════════════════════════════════════════════════');
  print('💡 You can now run the batch generator again to fill any real missing images.');
  print('══════════════════════════════════════════════════');
}
