import '../data/prompt_library.dart';
import 'dart:convert';
import 'dart:io';

void main() async {
  final allPrompts = PromptLibrary.getAllPrompts();
  final jsonFile = File('generated_images.json');
  final Map<String, dynamic> jsonData = jsonDecode(await jsonFile.readAsString());

  print('📊 NEXORA DUPLICATE AUDIT\n');

  final Set<String> uniqueTitles = {};
  final List<String> duplicates = [];

  for (var p in allPrompts) {
    final title = p['title'];
    if (uniqueTitles.contains(title)) {
      duplicates.add(title);
    } else {
      uniqueTitles.add(title);
    }
  }

  if (duplicates.isEmpty) {
    print('✅ No duplicate titles found in Code.');
  } else {
    print('⚠️ DUPLICATE TITLES FOUND:');
    for (var d in duplicates) {
      print('   - "$d"');
    }
    print('\n💡 FIX: Go to the prompt file and give these a unique name.');
  }

  print('\n📈 SUMMARY:');
  print('   - Total items in Code  : ${allPrompts.length}');
  print('   - Unique titles in Code: ${uniqueTitles.length}');
  print('   - Entries in JSON      : ${jsonData.length}');

  if (uniqueTitles.length == jsonData.length && allPrompts.length == uniqueTitles.length) {
    print('\n✅ STATUS: PERFECT SYNC!');
  } else {
    print('\n❌ STATUS: MISMATCH DETECTED.');
  }
}
