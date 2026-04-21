import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:nexora/config/app_theme.dart';
import 'package:nexora/providers/auth_provider.dart';
import 'package:nexora/providers/prompt_provider.dart';
import 'package:nexora/screens/splash/splash_screen.dart';

void main() {
  testWidgets('App starts with SplashScreen', (WidgetTester tester) async {
    // 1. Mock SharedPreferences
    SharedPreferences.setMockInitialValues({});

    // 2. Build our app based on the new "Light Only" main.dart structure
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          // Provide the required providers but without ThemeProvider
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => PromptProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light, // ✅ Forced Light Mode
          theme: AppTheme.lightTheme, // ✅ Clean Light Theme
          home: const SplashScreen(),
        ),
      ),
    );

    // 3. Verify SplashScreen shows up
    expect(find.byType(SplashScreen), findsOneWidget);

    // 4. Verify the background color is correct (Pure White as requested)
    final Scaffold scaffold = tester.widget(find.byType(Scaffold));
    expect(scaffold.backgroundColor, Colors.white);
  });
}