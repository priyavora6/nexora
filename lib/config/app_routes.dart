import 'package:flutter/material.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/categories/categories_screen.dart';
import '../screens/categories/category_detail_screen.dart';
import '../screens/categories/subcategory.dart';
import '../screens/prompts/prompt_detail_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/favorites/favorites_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/profile/feedback_screen.dart';
import '../screens/profile/contact_us_screen.dart';
import '../screens/profile/privacy_policy_screen.dart';
import '../screens/profile/about_app_screen.dart';
import '../screens/profile/developer_info_screen.dart';
import '../widgets/common/webview_screen.dart';

import '../screens/admin/admin_dashboard_screen.dart';
import '../screens/admin/manage_categories_screen.dart';
import '../screens/admin/manage_prompts_screen.dart';
import '../screens/admin/add_edit_category_screen.dart';
import '../screens/admin/add_edit_prompt_screen.dart';

class AppRoutes {
  AppRoutes._();

  // ═══════════════════════════════
  // Route names
  // ═══════════════════════════════
  static const String splash           = '/';
  static const String onboarding       = '/onboarding';
  static const String login            = '/login';
  static const String signup           = '/signup';

  // Main screens (each has bottom nav)
  static const String home             = '/home';
  static const String categories       = '/categories';
  static const String search           = '/search';
  static const String favorites        = '/favorites';
  static const String profile          = '/profile';

  // Detail screens
  static const String categoryDetail   = '/category-detail';
  static const String subcategoryDetail = '/subcategory-detail';
  static const String promptDetail     = '/prompt-detail';
  static const String webView          = '/webview';

  // Profile Sub-pages
  static const String feedback         = '/feedback';
  static const String contactUs        = '/contact-us';
  static const String privacyPolicy    = '/privacy-policy';
  static const String aboutApp         = '/about-app';
  static const String developerInfo    = '/developer-info';

  // Admin screens
  static const String adminLogin       = '/admin-login';
  static const String adminDash        = '/admin-dashboard';
  static const String manageCategories = '/manage-categories';
  static const String managePrompts    = '/manage-prompts';
  static const String addEditCategory  = '/add-edit-category';
  static const String addEditPrompt    = '/add-edit-prompt';

  // ═══════════════════════════════
  // Route generator
  // ═══════════════════════════════
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
    // ── Auth flow ──
      case splash:
        return _fade(SplashScreen());
      case onboarding:
        return _fade(OnboardingScreen());
      case login:
        return _fade(LoginScreen());
      case signup:
        return _slide(SignupScreen());

    // ── Main screens (bottom nav — NO animation for tab switches) ──
      case home:
        return _noAnimation(HomeScreen());
      case categories:
        return _noAnimation(CategoriesScreen());
      case search:
        return _noAnimation(SearchScreen());
      case favorites:
        return _noAnimation(FavoritesScreen());
      case profile:
        return _noAnimation(ProfileScreen());

    // ── Detail screens ──
      case categoryDetail:
        final args = settings.arguments as Map<String, dynamic>;
        return _slide(CategoryDetailScreen(
          categoryId: args['categoryId'],
          categoryName: args['categoryName'],
          categoryColor: args['categoryColor'],
        ));
      case subcategoryDetail:
        final args = settings.arguments as Map<String, dynamic>;
        return _slide(SubcategoryDetailScreen(
          categoryId: args['categoryId'],
          categoryName: args['categoryName'],
          subcategoryId: args['subcategoryId'],
          subcategoryName: args['subcategoryName'],
          categoryColor: args['categoryColor'],
        ));
      case promptDetail:
        final args = settings.arguments as Map<String, dynamic>;
        return _slide(PromptDetailScreen(promptId: args['promptId']));

      case webView:
        final args = settings.arguments as Map<String, dynamic>;
        return _slide(WebViewScreen(
          url: args['url'],
          title: args['title'],
        ));

    // ── Profile Sub-pages ──
      case feedback:
        return _slide(const FeedbackScreen());
      case contactUs:
        return _slide(const ContactUsScreen());
      case privacyPolicy:
        return _slide(const PrivacyPolicyScreen());
      case aboutApp:
        return _slide(const AboutAppScreen());
      case developerInfo:
        return _slide(const DeveloperInfoScreen());

    // ── Admin screens ──

      case adminDash:
        return _fade(AdminDashboardScreen());
      case manageCategories:
        return _slide(ManageCategoriesScreen());
      case managePrompts:
        return _slide(ManagePromptsScreen());
      case addEditCategory:
        final args = settings.arguments as Map<String, dynamic>?;
        return _slide(AddEditCategoryScreen(category: args?['category']));
      case addEditPrompt:
        final args = settings.arguments as Map<String, dynamic>?;
        return _slide(AddEditPromptScreen(prompt: args?['prompt']));

      default:
        return _fade(SplashScreen());
    }
  }

  // ── No animation (for bottom nav tab switching) ──
  static PageRouteBuilder _noAnimation(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }

  // ── Fade transition ──
  static PageRouteBuilder _fade(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, a, __, child) =>
          FadeTransition(opacity: a, child: child),
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

  // ── Slide transition ──
  static PageRouteBuilder _slide(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, a, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}
