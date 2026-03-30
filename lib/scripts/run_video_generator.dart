// lib/scripts/run_video_generator.dart

import 'package:flutter_test/flutter_test.dart'; // Add this
import 'batch_video_generator.dart';

void main() {
  // Use a standard test block to handle Flutter dependencies and timeouts
  test('AI Video Batch Generation', () async {
    print('\n');
    print('╔═══════════════════════════════════════════════════════════╗');
    print('║         🎥 AI VIDEO BATCH GENERATOR                      ║');
    print('╚═══════════════════════════════════════════════════════════╝');
    print('\n');

    print('This script will:');
    print('  ✅ Read generated_images.json');
    print('  ✅ Generate videos via Replicate (SVD/Kling)');
    print('  ✅ Upload to your Cloudinary (dli0cf2x3)');
    print('  ✅ Save links to generated_videos.json');
    print('\n');

    print('⚠️  WARNING: Each video takes about 1-2 minutes to process.');
    print('⏱️  Estimated time for ~120 videos: 2.5 to 3 hours.');
    print('💰 Cost: Will use approximately \$4.50 of Replicate credit.');
    print('\n');

    print('🚀 STARTING VIDEO ENGINE NOW...\n');

    // NOTE: Removed stdin.readLineSync() because it hangs in terminal tests

    final generator = BatchVideoGenerator();

    try {
      await generator.generateAllVideos();
    } catch (e) {
      print('\n🛑 CRITICAL SCRIPT ERROR: $e');
    }

    print('\n✨ Process Finished. You can now run the Seed button in your app.');

  }, timeout: const Timeout(Duration(hours: 4))); // 4-hour timeout for 120 videos
}