// lib/scripts/upload_manual_images.dart
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

// ─── CLOUDINARY CONFIG ───
const String cloudName = 'dli0cf2x3';
const String uploadPreset = 'nexora_unsigned';

void main() async {
  print('═══════════════════════════════════════════════════════════');
  print('📤 UPLOADING MANUAL IMAGES TO CLOUDINARY (ROBUST VERSION)');
  print('═══════════════════════════════════════════════════════════\n');

  final manualFolder = Directory('manual_images');
  final todoFile = File('items_to_generate.json');
  final progressFile = File('generated_images.json');

  if (!await manualFolder.exists()) {
    print('❌ ERROR: "manual_images" folder not found!');
    return;
  }

  if (!await todoFile.exists()) {
    print('❌ ERROR: "items_to_generate.json" not found!');
    return;
  }

  List<dynamic> todoItems = jsonDecode(await todoFile.readAsString());
  Map<String, dynamic> progressData = {};
  if (await progressFile.exists()) {
    progressData = Map<String, dynamic>.from(jsonDecode(await progressFile.readAsString()));
  }

  final List<FileSystemEntity> files = manualFolder.listSync();
  print('📂 Found ${files.length} images in manual_images folder.\n');

  int successCount = 0;
  final client = http.Client(); 

  try {
    for (var fileEntity in files) {
      if (fileEntity is! File) continue;
      
      final fileName = fileEntity.path.split(Platform.pathSeparator).last;
      print('📦 Processing: $fileName');

      final matchingItem = todoItems.firstWhere(
        (item) => item['filename'] == fileName,
        orElse: () => null,
      );

      if (matchingItem == null) {
        print('   ⚠️  SKIPPING: Filename not found in items_to_generate.json');
        continue;
      }

      final title = matchingItem['title'] ?? fileName.replaceAll('.jpg', '').replaceAll('_', ' ');
      final category = matchingItem['category'] ?? 'General';
      final text = matchingItem['text'] ?? '';

      try {
        final bytes = await fileEntity.readAsBytes();
        
        String url = "";
        for (int attempt = 1; attempt <= 3; attempt++) {
          url = await _manualUpload(client, bytes, title, category);
          if (url.isNotEmpty) break;
          
          if (attempt < 3) {
            print('      ⏳ Retry $attempt/3 after network hiccup...');
            await Future.delayed(Duration(seconds: 2 * attempt));
          }
        }

        if (url.isNotEmpty) {
          progressData[title] = {
            'title': title,
            'text': text,
            'category': category,
            'cloudinaryUrl': url,
            'filename': fileName,
            'generatedAt': DateTime.now().toIso8601String(),
            'manualUpload': true,
          };

          successCount++;
          print('   ✅ UPLOADED: $url');
          await progressFile.writeAsString(JsonEncoder.withIndent('  ').convert(progressData));
        } else {
          print('   ❌ FAILED to upload after 3 attempts: $fileName');
        }
      } catch (e) {
        print('   ❌ ERROR: $e');
      }
      print('───────────────────────────────────────────────────────────');
    }
  } finally {
    client.close();
  }

  if (successCount > 0) {
    final remainingTodo = todoItems.where((item) => !progressData.containsKey(item['title'] ?? item['filename'].replaceAll('.jpg', '').replaceAll('_', ' '))).toList();
    await todoFile.writeAsString(JsonEncoder.withIndent('  ').convert(remainingTodo));
    print('\n📝 Updated items_to_generate.json. Remaining: ${remainingTodo.length}');
  }

  print('\n🎉 FINISHED! $successCount images integrated.');
}

Future<String> _manualUpload(http.Client client, Uint8List bytes, String title, String category) async {
  String clean(String input) => input.toLowerCase()
      .replaceAll('&', 'and') 
      .replaceAll(RegExp(r'[^a-z0-9]'), '_')
      .replaceAll(RegExp(r'_+'), '_');

  final safeCategory = clean(category);
  final safeTitle = clean(title);

  final request = http.MultipartRequest(
    'POST',
    Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload'),
  );

  request.fields['upload_preset'] = uploadPreset;
  request.fields['folder'] = 'nexora_examples_$safeCategory';
  request.fields['public_id'] = safeTitle;
  request.files.add(http.MultipartFile.fromBytes('file', bytes, filename: 'upload.jpg'));

  try {
    final streamedResponse = await client.send(request).timeout(const Duration(seconds: 60));
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['secure_url'];
    } else {
      print('      ⚠️  Cloudinary Error (${response.statusCode}): ${response.body}');
    }
  } catch (e) {
    print('      ⚠️  Network error: $e');
  }
  return '';
}
