import 'package:flutter/material.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/auth/otp_verification_screen.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/auth/interests_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/categories/categories_screen.dart';
import '../screens/categories/category_detail_screen.dart';
import '../screens/categories/subcategory.dart';
import '../screens/prompts/prompt_detail_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/favorites/favorites_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/settings/feedback_screen.dart';
import '../screens/settings/contact_us_screen.dart';
import '../screens/settings/privacy_policy_screen.dart';
import '../screens/settings/about_app_screen.dart';
import '../screens/settings/developer_info_screen.dart';
import '../screens/settings/change_password_screen.dart';
import '../screens/settings/how_to_use_screen.dart';
import '../screens/settings/edit_profile_screen.dart';
import '../widgets/common/webview_screen.dart';

import '../screens/admin/admin_dashboard_screen.dart';
import '../screens/admin/manage_categories_screen.dart';
import '../screens/admin/manage_prompts_screen.dart';
import '../screens/admin/add_edit_category_screen.dart';
import '../screens/admin/add_edit_prompt_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash           = '/';
  static const String onboarding       = '/onboarding';
  static const String login            = '/login';
  static const String signup           = '/signup';
  static const String otpVerify        = '/otp-verify';
  static const String forgotPassword   = '/forgot-password';
  static const String interests        = '/interests';

  static const String home             = '/home';
  static const String categories       = '/categories';
  static const String search           = '/search';
  static const String favorites        = '/favorites';
  static const String settings         = '/settings';

  static const String categoryDetail   = '/category-detail';
  static const String subcategoryDetail = '/subcategory-detail';
  static const String promptDetail     = '/prompt-detail';
  static const String webView          = '/webview';

  static const String feedback         = '/feedback';
  static const String contactUs        = '/contact-us';
  static const String privacyPolicy    = '/privacy-policy';
  static const String aboutApp         = '/about-app';
  static const String developerInfo    = '/developer-info';
  static const String changePassword   = '/change-password';
  static const String editProfile      = '/edit-profile';
  static const String howToUse         = '/how-to-use';

  static const String adminDash        = '/admin-dashboard';
  static const String manageCategories = '/manage-categories';
  static const String managePrompts    = '/manage-prompts';
  static const String addEditCategory  = '/add-edit-category';
  static const String addEditPrompt    = '/add-edit-prompt';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _fade(SplashScreen());
      case onboarding:
        return _fade(OnboardingScreen());
      case login:
        return _fade(LoginScreen());
      case signup:
        return _slide(SignupScreen());
      case otpVerify:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => OTPVerificationScreen(
            name: args['name'],
            email: args['email'],
            password: args['password'],
            otp: args['otp'],
            expiryTime: args['expiryTime'],
          ),
        );
      case forgotPassword:
        return _slide(const ForgotPasswordScreen());
      case interests:
        return MaterialPageRoute(builder: (_) => const InterestsSelectionScreen());

      case home:
        return _noAnimation(HomeScreen());
      case categories:
        return _noAnimation(CategoriesScreen());
      case search:
        return _noAnimation(const SearchScreen());
      case favorites:
        return _noAnimation(FavoritesScreen());
      case AppRoutes.settings:
        return _noAnimation(const SettingsScreen());

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
      case changePassword:
        return _slide(const ChangePasswordScreen());
      case editProfile:
        return _slide(const EditProfileScreen());
      case howToUse:
        return _slide(const HowToUseScreen());

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

  static PageRouteBuilder _noAnimation(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }

  static PageRouteBuilder _fade(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, a, __, child) =>
          FadeTransition(opacity: a, child: child),
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

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
