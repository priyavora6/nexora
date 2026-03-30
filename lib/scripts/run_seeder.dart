// lib/scripts/run_seeder.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nexora/services/seed/seed_data_service.dart';
import 'package:nexora/firebase_options.dart';

void main() {
  test('Push JSON to Firebase', () async {
    print('🚀 STARTING ADMIN SEEDER...');

    // 1. Initialize Firebase for Test Environment
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    
    final seeder = SeedDataService();
    
    await seeder.seedAllData(onProgress: (msg) {
      print('   $msg');
    });

    print('✅ DATABASE UPDATED WITH CLOUDINARY LINKS!');
  }, timeout: const Timeout(Duration(minutes: 30)));
}
