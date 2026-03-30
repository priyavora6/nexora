import 'package:flutter_test/flutter_test.dart';
import 'batch_image_generator.dart';

void main() {
  // Use 'test' instead of 'testWidgets' for logic-heavy scripts
  test('Batch AI Image Generation', () async {
    print('🚀 INITIALIZING...');

    final generator = BatchImageGenerator();

    // This will now handle Future.delayed correctly!
    await generator.generateAllImages();

    print('✅ FINISHED!');
  }, timeout: const Timeout(Duration(hours: 4)));
}