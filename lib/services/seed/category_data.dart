// lib/services/seed/category_data.dart

// class CategoryData {
//   // ═══════════════════════════════════════════════════════════════
//   // 🎨 CARD THEME COLORS (Consistent Purple Theme)
//   // ═══════════════════════════════════════════════════════════════
//
//   // Light purple for card background
//   static const String cardBgColor = '#F3EFFA';
//
//   // Dark purple for border and text
//   static const String cardAccentColor = '#7E57C2';
//
//   static List<Map<String, String>> getAllCategories() {
//     return [
//       {
//         'name': 'Portrait & Headshots',
//         'color': cardAccentColor,
//         'bgColor': cardBgColor,
//       },
//       {
//         'name': 'Couple & Romance',
//         'color': cardAccentColor,
//         'bgColor': cardBgColor,
//       },
//       {
//         'name': 'Wedding & Marriage',
//         'color': cardAccentColor,
//         'bgColor': cardBgColor,
//       },
//       {
//         'name': 'Family & Kids',
//         'color': cardAccentColor,
//         'bgColor': cardBgColor,
//       },
//       {
//         'name': 'Festivals & Occasions',
//         'color': cardAccentColor,
//         'bgColor': cardBgColor,
//       },
//       {
//         'name': 'Business & Marketing',
//         'color': cardAccentColor,
//         'bgColor': cardBgColor,
//       },
//       {
//         'name': 'Product & E-commerce',
//         'color': cardAccentColor,
//         'bgColor': cardBgColor,
//       },
//       {
//         'name': 'Art Styles',
//         'color': cardAccentColor,
//         'bgColor': cardBgColor,
//       },
//       {
//         'name': 'Nature & Landscapes',
//         'color': cardAccentColor,
//         'bgColor': cardBgColor,
//       },
//       {
//         'name': 'Animals & Pets',
//         'color': cardAccentColor,
//         'bgColor': cardBgColor,
//       },
//       {
//         'name': 'Food & Restaurant',
//         'color': cardAccentColor,
//         'bgColor': cardBgColor,
//       },
//       {
//         'name': 'Fashion & Lifestyle',
//         'color': cardAccentColor,
//         'bgColor': cardBgColor,
//       },
//       {
//         'name': 'Vehicles & Travel',
//         'color': cardAccentColor,
//         'bgColor': cardBgColor,
//       },
//       {
//         'name': 'Social Media',
//         'color': cardAccentColor,
//         'bgColor': cardBgColor,
//       },
//       {
//         'name': 'Photo Enhancement',
//         'color': cardAccentColor,
//         'bgColor': cardBgColor,
//       },
//       {
//         'name': 'AI Tools & Platforms',
//         'color': cardAccentColor,
//         'bgColor': cardBgColor,
//       },
//       {
//         'name': 'Gaming & Esports',
//         'color': cardAccentColor,
//         'bgColor': cardBgColor,
//       },
//       {
//         'name': 'Architecture & Interiors',
//         'color': cardAccentColor,
//         'bgColor': cardBgColor,
//       },
//     ];
//   }
// }



// lib/services/seed/category_data.dart

class CategoryData {
  // 🎨 Modern Purple Theme
  static const String cardBgColor = '#F5F2FB';
  static const String cardAccentColor = '#6C4AB6';

  static List<Map<String, String>> getAllCategories() {
    return [
      _cat('Portrait & Headshots'),
      _cat('Couple & Romance'),
      _cat('Wedding & Marriage'),
      _cat('Family & Kids'),
      _cat('Festivals & Occasions'),
      _cat('Business & Marketing'),
      _cat('Product & E-commerce'),
      _cat('Art Styles'),
      _cat('Nature & Landscapes'),
      _cat('Animals & Pets'),
      _cat('Food & Restaurant'),
      _cat('Fashion & Lifestyle'),
      _cat('Vehicles & Travel'),
      _cat('Social Media'),
      _cat('Photo Enhancement'),
      _cat('AI Tools & Platforms'),
      _cat('Gaming & Esports'),
      _cat('Architecture & Interiors'),
    ];
  }

  static Map<String, String> _cat(String name) {
    return {
      'name': name,
      'color': cardAccentColor,
      'bgColor': cardBgColor,
    };
  }
}
