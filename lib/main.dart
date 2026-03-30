import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'firebase_options.dart';
import 'config/app_routes.dart';
import 'config/app_theme.dart';
import 'providers/auth_provider.dart' as app_auth;
import 'providers/prompt_provider.dart';
import 'providers/admin_provider.dart'; // ✅ Import your AdminProvider
import 'screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Load environment variables
  await dotenv.load(fileName: ".env");

  // 2. Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 3. Set Status Bar to transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(const NexoraApp());
}

class NexoraApp extends StatelessWidget {
  const NexoraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ✅ User Auth Provider
        ChangeNotifierProvider(create: (_) => app_auth.AuthProvider()),

        // ✅ Prompt Provider (Data)
        ChangeNotifierProvider(create: (_) => PromptProvider()),

        // ✅ ADDED: Admin Provider (Permissions & State)
        ChangeNotifierProvider(create: (_) => AdminProvider()..checkAdminStatus()),
      ],
      child: MaterialApp(
        title: 'Nexora',
        debugShowCheckedModeBanner: false,

        // ☀️ FORCE LIGHT MODE: Removed ThemeMode.system
        themeMode: ThemeMode.light, 

        // ☀️ LIGHT THEME
        theme: AppTheme.lightTheme,

        // 🚀 App Entry Points
        home: const SplashScreen(),
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
