import '../data/prompt_library.dart';

void main() {
  final allPrompts = PromptLibrary.getAllPrompts();

  print('🔍 Identifying Active Cloudinary Images...');

  // 1. Collect all Public IDs that ARE being used in your app
  Set<String> activePublicIds = {};

  for (var p in allPrompts) {
    String url = p['cloudinaryUrl']?.toString() ?? '';
    if (url.isNotEmpty) {
      // Extracts "category/image_name" from the Cloudinary URL
      // Logic assumes URL format: .../upload/v12345/nexora/category/name.jpg
      try {
        final uri = Uri.parse(url);
        final pathSegments = uri.pathSegments;
        final uploadIndex = pathSegments.indexOf('upload');
        if (uploadIndex != -1) {
          // Join segments after the version (v12345...)
          final publicIdWithExt = pathSegments.sublist(uploadIndex + 2).join('/');
          // Remove extension (.jpg, .png)
          final publicId = publicIdWithExt.split('.').first;
          activePublicIds.add(publicId);
        }
      } catch (e) {
        // Skip invalid URLs
      }
    }
  }

  print('✅ Found ${activePublicIds.length} unique active images in library.');
  print('\n💡 NEXT STEPS TO CLEAN CLOUDINARY:');
  print('1. Log into your Cloudinary Dashboard.');
  print('2. Go to Media Library > nexora folder.');
  print('3. Any image NOT in the following list can be safely deleted:\n');

  for (var id in activePublicIds) {
    print('   - $id');
  }

  print('\n⚠️ WARNING: Always backup your "generated_images.json" before manual deletion.');
}