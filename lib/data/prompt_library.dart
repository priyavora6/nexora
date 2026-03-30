// lib/data/prompt_library.dart
import '../services/seed/category_data.dart';
import '../services/seed/subcategory_data.dart';
import '../services/seed/prompts/portrait_headshots_prompts.dart';
import '../services/seed/prompts/couple_romance_prompts.dart';
import '../services/seed/prompts/wedding_marriage_prompts.dart';
import '../services/seed/prompts/family_kids_prompts.dart';
import '../services/seed/prompts/festivals_occasions_prompts.dart';
import '../services/seed/prompts/business_marketing_prompts.dart';
import '../services/seed/prompts/product_ecommerce_prompts.dart';
import '../services/seed/prompts/art_styles_prompts.dart';
import '../services/seed/prompts/nature_landscapes_prompts.dart';
import '../services/seed/prompts/animals_pets_prompts.dart';
import '../services/seed/prompts/food_restaurant_prompts.dart';
import '../services/seed/prompts/fashion_lifestyle_prompts.dart';
import '../services/seed/prompts/vehicles_travel_prompts.dart';
import '../services/seed/prompts/social_media_prompts.dart';
import '../services/seed/prompts/photo_enhancement_prompts.dart';
import '../services/seed/prompts/ai_tools_platforms_prompts.dart';
import '../services/seed/prompts/gaming_esports_prompts.dart';
import '../services/seed/prompts/architecture_interiors_prompts.dart';

class PromptLibrary {
  static List<Map<String, dynamic>> getAllPrompts() {
    final List<Map<String, dynamic>> allPrompts = [];
    final categories = CategoryData.getAllCategories();

    for (final cat in categories) {
      final catName = cat['name']!;
      final subs = SubcategoryData.getSubcategories(catName);

      for (final sub in subs) {
        final subName = sub['name']!;
        final prompts = _getPrompts(catName, subName);
        
        // Inject category/subcategory info for syncing
        for (var p in prompts) {
          p['category'] = catName;
          p['subcategory'] = subName;
        }
        
        allPrompts.addAll(prompts);
      }
    }
    return allPrompts;
  }

  static List<Map<String, dynamic>> _getPrompts(String category, String subcategory) {
    switch (category) {
      case 'Portrait & Headshots': return PortraitHeadshotsPrompts.getPrompts(subcategory);
      case 'Couple & Romance': return CoupleRomancePrompts.getPrompts(subcategory);
      case 'Wedding & Marriage': return WeddingMarriagePrompts.getPrompts(subcategory);
      case 'Family & Kids': return FamilyKidsPrompts.getPrompts(subcategory);
      case 'Festivals & Occasions': return FestivalsOccasionsPrompts.getPrompts(subcategory);
      case 'Business & Marketing': return BusinessMarketingPrompts.getPrompts(subcategory);
      case 'Product & E-commerce': return ProductEcommercePrompts.getPrompts(subcategory);
      case 'Art Styles': return ArtStylesPrompts.getPrompts(subcategory);
      case 'Nature & Landscapes': return NatureLandscapesPrompts.getPrompts(subcategory);
      case 'Animals & Pets': return AnimalsPetsPrompts.getPrompts(subcategory);
      case 'Food & Restaurant': return FoodRestaurantPrompts.getPrompts(subcategory);
      case 'Fashion & Lifestyle': return FashionLifestylePrompts.getPrompts(subcategory);
      case 'Vehicles & Travel': return VehiclesTravelPrompts.getPrompts(subcategory);
      case 'Social Media': return SocialMediaPrompts.getPrompts(subcategory);
      case 'Photo Enhancement': return PhotoEnhancementPrompts.getPrompts(subcategory);
      case 'AI Tools & Platforms': return AIToolsPlatformsPrompts.getPrompts(subcategory);
      case 'Gaming & Esports': return GamingEsportsPrompts.getPrompts(subcategory);
      case 'Architecture & Interiors': return ArchitectureInteriorsPrompts.getPrompts(subcategory);
      default: return [];
    }
  }
}
