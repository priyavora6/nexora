
import 'dart:convert';
import 'dart:io';
import '../services/seed/prompts/ai_tools_platforms_prompts.dart';

void main() async {
  final jsonFile = File('assets/generated_images.json');
  if (!await jsonFile.exists()) {
    print('❌ ERROR: assets/generated_images.json file not found!');
    return;
  }

  // 1. Load existing JSON
  final String jsonContent = await jsonFile.readAsString();
  Map<String, dynamic> jsonData = jsonDecode(jsonContent);

  print('📊 Current JSON count: ${jsonData.length}');

  // 2. Get prompts for missing subcategories
  final List<String> targetSubcategories = ['Kling Runway', 'Flux Ideogram'];
  int addedCount = 0;

  for (var sub in targetSubcategories) {
    print('\n🔎 Checking subcategory: $sub');
    final prompts = AIToolsPlatformsPrompts.getPrompts(sub);
    
    for (var p in prompts) {
      final title = p['title'] as String;
      
      if (!jsonData.containsKey(title)) {
        // Add dummy entry (to be filled by batch generator)
        jsonData[title] = {
          "title": title,
          "category": "AI Tools & Platforms",
          "subcategory": sub,
          "platform": p['platform'],
          "cloudinaryUrl": "", // Will be generated
          "isFeatured": p['isFeatured'] ?? "false"
        };
        print('   ✅ Added: $title');
        addedCount++;
      } else {
        print('   ⏩ Skipping (already exists): $title');
      }
    }
  }

  // 3. Save back to file
  if (addedCount > 0) {
    await jsonFile.writeAsString(JsonEncoder.withIndent('  ').convert(jsonData));
    print('\n✅ SUCCESS! Added $addedCount new entries to JSON.');
    print('🚀 Now run your batch generator to generate the actual images.');
  } else {
    print('\n🙌 No new entries needed. Everything is already in the JSON!');
  }
}
