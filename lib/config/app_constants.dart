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
    'ChatGPT',
    'Luma AI',
    'Pika Labs',
    'Other',
  ];

  static const Map<String, String> platformKeys = {
    'Midjourney': 'midjourney',
    'Leonardo AI': 'leonardo',
    'DALL-E 3': 'dalle',
    'Stable Diffusion XL': 'stable_diffusion',
    'Ideogram': 'ideogram',
    'Kling AI': 'kling',
    'Runway ML': 'runway',
    'Adobe Firefly': 'firefly',
    'Sora': 'sora',
    'ChatGPT': 'chatgpt',
    'Luma AI': 'luma',
    'Pika Labs': 'pika',
    'Other': 'other',
  };

  static const Map<String, String> platformUrls = {
    'midjourney': 'https://discord.com/channels/midjourney',
    'leonardo': 'https://app.leonardo.ai/',
    'dalle': 'https://labs.openai.com/',
    'stable_diffusion': 'https://stablediffusionweb.com/',
    'ideogram': 'https://ideogram.ai/',
    'kling': 'https://klingai.com/text-to-video',
    'runway': 'https://runwayml.com/',
    'firefly': 'https://firefly.adobe.com/',
    'sora': 'https://openai.com/sora',
    'chatgpt': 'https://chat.openai.com/',
    'luma': 'https://lumalabs.ai/dream-machine',
    'pika': 'https://pika.art/',
    'other': '',
  };

  static const Map<String, String> platformColors = {
    'midjourney': '#9B72CB',
    'leonardo': '#FF6B35',
    'dalle': '#10A37F',
    'stable_diffusion': '#4A90E2',
    'ideogram': '#FF6B9D',
    'kling': '#7C3AED',
    'runway': '#000000',
    'firefly': '#FF0000',
    'sora': '#10A37F',
    'chatgpt': '#10A37F',
    'luma': '#8B5CF6',
    'pika': '#EC4899',
    'other': '#6B7280',
  };

  static const String placeholderImage = 'https://via.placeholder.com/400x300?text=No+Preview';
  static const String placeholderThumbnail = 'https://via.placeholder.com/150x150?text=Nexora';
  static const String errorImage = 'https://via.placeholder.com/400x300?text=Image+Not+Found';

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
  // 🏷️ CATEGORY EMOJIS
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

  static const String exampleTypeImage = 'image';
  static const String exampleTypeVideo = 'video';
  static const String exampleTypeNone = 'none';

  static const int maxHeroExamples = 5;
  static const int minPromptLength = 10;
  static const int maxPromptLength = 5000;
  static const int maxTagsPerPrompt = 10;
}
