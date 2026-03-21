class AppConstants {
  AppConstants._();

  // ═══════════════════════════════════════
  // 📱 APP INFO
  // ═══════════════════════════════════════
  static const String appName    = 'NEXORA';
  static const String appTagline = 'NEXT-GEN CREATIVE PLATFORM';
  static const String appVersion = '1.0.0';

  // ═══════════════════════════════════════
  // ⏱️ TIMING
  // ═══════════════════════════════════════
  static const int splashDuration    = 4;  // seconds
  static const int animationDuration = 2;  // seconds

  // ═══════════════════════════════════════
  // 💾 SHARED PREFERENCES KEYS
  // ═══════════════════════════════════════
  static const String keyOnboardingSeen = 'onboarding_seen';
  static const String keyFavorites      = 'favorite_prompts';
  static const String keyThemeMode      = 'theme_mode';
  static const String keyRecentSearch   = 'recent_searches';

  // ═══════════════════════════════════════
  // 🔐 ADMIN CREDENTIALS
  // ═══════════════════════════════════════
  // ⚠️ These must match what you created in Firebase Console!
  // ⚠️ Create admin in: Firebase Console → Authentication → Add User
  // ⚠️ Then add UID to: Firebase Console → Firestore → admins/{UID}
  // ═══════════════════════════════════════
  static const String adminEmail    = 'admin@nexora.com';
  static const String adminPassword = 'Nexora@Admin2024';

  // ═══════════════════════════════════════
  // 🤖 AI PLATFORMS
  // ═══════════════════════════════════════
  static const List<String> aiPlatforms = [
    'Midjourney',
    'Leonardo AI',
    'DALL-E 3',
    'Stable Diffusion XL',
    'Ideogram',
    'Kling AI',
    'Runway ML',
    'Adobe Firefly',
    'Sora',
    'Other',
  ];

  // ═══════════════════════════════════════
  // 🎯 ONBOARDING PAGES
  // ═══════════════════════════════════════
  static const List<Map<String, String>> onboardingPages = [
    {
      'title': 'Discover AI Prompts',
      'subtitle': 'Explore a vast collection of handcrafted prompts\nfor every AI platform imaginable',
      'emoji': '✨',
    },
    {
      'title': 'Organize by Category',
      'subtitle': 'Browse through perfectly organized categories\nfrom portraits to landscapes and beyond',
      'emoji': '🗂️',
    },
    {
      'title': 'One Tap Copy & Use',
      'subtitle': 'Copy any prompt instantly with a single tap\nand paste directly into your favorite AI tool',
      'emoji': '⚡',
    },
  ];

  // ═══════════════════════════════════════
  // 🏷️ CATEGORY EMOJIS (for quick reference)
  // ═══════════════════════════════════════
  static const Map<String, String> categoryEmojis = {
    'Portrait Photography': '📸',
    'Landscape': '🏔️',
    'Fantasy Art': '🧙',
    'Sci-Fi': '🚀',
    'Anime & Manga': '🎌',
    'Logo Design': '✏️',
    'Icon Design': '🔷',
    'UI/UX Design': '📱',
    'Architecture': '🏛️',
    'Interior Design': '🛋️',
    'Fashion': '👗',
    'Food Photography': '🍕',
    'Product Photography': '📦',
    'Abstract Art': '🎨',
    '3D Rendering': '🧊',
    'Character Design': '🦸',
    'Concept Art': '💡',
    'Digital Painting': '🖌️',
    'Illustration': '✍️',
    'Tattoo Design': '💀',
    'Typography': '🔤',
    'Poster Design': '🖼️',
    'Book Cover': '📚',
    'Social Media': '📲',
    'Wallpaper': '🌌',
    'Texture & Pattern': '🔲',
    'Wildlife': '🦁',
    'Space & Cosmic': '🌠',
    'Horror & Dark': '👻',
    'Vintage & Retro': '📻',
    'Minimalist': '⬜',
    'Surreal Art': '🌀',
    'Pixel Art': '👾',
  };
}
