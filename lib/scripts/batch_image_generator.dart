// lib/scripts/batch_image_generator.dart

import 'dart:convert';
import 'dart:io';
import '../services/media_generator_service.dart';
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

class BatchImageGenerator {
  final MediaGeneratorService _mediaService = MediaGeneratorService();

  // Configuration
  static const int DELAY_SECONDS = 3; // Delay between requests

  /// Main function to generate all images with Resume logic
  Future<void> generateAllImages() async {
    print('═══════════════════════════════════════════════════════════');
    print('🎨 AI MEDIA BATCH GENERATOR (WITH RESUME)');
    print('═══════════════════════════════════════════════════════════\n');

    // 1. ALWAYS LOAD EXISTING DATA FIRST
    Map<String, dynamic> generatedResults = await _loadExistingProgress();
    print('📊 Resuming... Already have ${generatedResults.length} images.');

    // 2. Get all prompts from library
    final allPrompts = _getAllPrompts();

    print('📊 Total prompts in library: ${allPrompts.length}');
    print('⏳ Remaining to process: ${allPrompts.length - generatedResults.length}');
    print('⏱️  Estimated time: ${((allPrompts.length - generatedResults.length) * (DELAY_SECONDS + 10) / 60).ceil()} minutes\n');

    int successCount = generatedResults.length;
    int failedCount = 0;

    for (int i = 0; i < allPrompts.length; i++) {
      final item = allPrompts[i];
      final title = item['title']?.toString() ?? '';
      final category = item['category']?.toString() ?? '';
      final subcategory = item['subcategory']?.toString() ?? '';
      final promptText = item['text']?.toString() ?? '';

      final num = i + 1;
      final total = allPrompts.length;

      // 2. SKIP if already in JSON
      if (generatedResults.containsKey(title)) {
        continue;
      }

      print('\n[$num/$total] 📸 Processing: $title');
      print('   Category: $category > $subcategory');

      try {
        // 3. GENERATE & UPLOAD IMAGE
        String url = await _mediaService.generateImage(
          promptText: promptText,
          title: title,
          category: category,
        );

        String videoUrl = "";

        // Optional: Generate Video if category requires it
        if (url.isNotEmpty && _mediaService.needsVideo(category, subcategory)) {
          print('   🎞️ VIDEO REQUIRED: Animating now...');
          videoUrl = await _mediaService.generateVideo(
            promptText: promptText,
            title: title,
            category: category,
            subcategory: subcategory,
            imageUrl: url,
          );
        }

        if (url.isNotEmpty) {
          // 4. ADD TO MAP
          generatedResults[title] = {
            "title": title,
            "category": category,
            "subcategory": subcategory,
            "platform": item['platform'],
            "cloudinaryUrl": url,
            "videoUrl": videoUrl,
            "isFeatured": item['isFeatured'],
          };

          successCount++;

          // 5. 🔥 CRITICAL: SAVE TO FILE IMMEDIATELY AFTER EVERY IMAGE
          // This way, if it crashes, you never lose even 1 image!
          await _saveProgress(generatedResults);
          print('   💾 Saved progress to JSON ($successCount/$total)');
        } else {
          failedCount++;
          print('   ❌ Generation failed for: $title');
        }

        // Delay to avoid rate limits and cool down
        await Future.delayed(Duration(seconds: DELAY_SECONDS));

      } catch (e) {
        failedCount++;
        print('   ❌ Process Error: $e');
        await Future.delayed(Duration(seconds: 10)); // Extra cooldown on error
      }
    }

    print('\n\n═══════════════════════════════════════════════════════════');
    print('🎉 BATCH GENERATION COMPLETE!');
    print('═══════════════════════════════════════════════════════════');
    print('✅ Total Successful: $successCount');
    print('❌ Failed this run: $failedCount');
    print('💾 Data saved to: generated_images.json');
    print('═══════════════════════════════════════════════════════════\n');
  }

  /// Load existing progress from JSON file as a Map
  Future<Map<String, dynamic>> _loadExistingProgress() async {
    try {
      final file = File('generated_images.json');
      if (await file.exists()) {
        final content = await file.readAsString();
        if (content.isNotEmpty) {
          final decoded = jsonDecode(content);
          if (decoded is Map) {
            return Map<String, dynamic>.from(decoded);
          } else if (decoded is List) {
            // Migration: Convert old List format to Map format
            Map<String, dynamic> converted = {};
            for (var item in decoded) {
              if (item is Map && item.containsKey('title')) {
                converted[item['title']] = item;
              }
            }
            return converted;
          }
        }
      }
    } catch (e) {
      print('⚠️ Could not load existing progress: $e');
    }
    return {};
  }

  /// Save progress to JSON file
  Future<void> _saveProgress(Map<String, dynamic> data) async {
    try {
      final file = File('generated_images.json');
      await file.writeAsString(
        JsonEncoder.withIndent('  ').convert(data),
      );
    } catch (e) {
      print('Error saving progress: $e');
    }
  }

  /// Get all prompts from all remaining categories
  List<Map<String, dynamic>> _getAllPrompts() {
    List<Map<String, dynamic>> all = [];

    // 1. Portrait & Headshots
    all.addAll(_extractPrompts('Portrait & Headshots', {
      'LinkedIn Professional': PortraitHeadshotsPrompts.getPrompts('LinkedIn Professional'),
      'Dating Profile': PortraitHeadshotsPrompts.getPrompts('Dating Profile'),
      'Corporate Business': PortraitHeadshotsPrompts.getPrompts('Corporate Business'),
      'Creative Artistic': PortraitHeadshotsPrompts.getPrompts('Creative Artistic'),
      'Actor Model Portfolio': PortraitHeadshotsPrompts.getPrompts('Actor Model Portfolio'),
      'Student Graduate': PortraitHeadshotsPrompts.getPrompts('Student Graduate'),
    }));

    // 2. Couple & Romance
    all.addAll(_extractPrompts('Couple & Romance', {
      'Valentine Special': CoupleRomancePrompts.getPrompts('Valentine Special'),
      'Engagement Proposal': CoupleRomancePrompts.getPrompts('Engagement Proposal'),
      'Couple Photoshoot': CoupleRomancePrompts.getPrompts('Couple Photoshoot'),
      'Pre-Wedding': CoupleRomancePrompts.getPrompts('Pre-Wedding'),
      'Anniversary': CoupleRomancePrompts.getPrompts('Anniversary'),
      'Romantic Scenes': CoupleRomancePrompts.getPrompts('Romantic Scenes'),
    }));

    // 3. Wedding & Marriage
    all.addAll(_extractPrompts('Wedding & Marriage', {
      'Bridal Portraits': WeddingMarriagePrompts.getPrompts('Bridal Portraits'),
      'Groom Portraits': WeddingMarriagePrompts.getPrompts('Groom Portraits'),
      'Haldi Ceremony': WeddingMarriagePrompts.getPrompts('Haldi Ceremony'),
      'Mehndi Function': WeddingMarriagePrompts.getPrompts('Mehndi Function'),
      'Wedding Ceremony': WeddingMarriagePrompts.getPrompts('Wedding Ceremony'),
      'Reception Party': WeddingMarriagePrompts.getPrompts('Reception Party'),
    }));

    // 4. Family & Kids
    all.addAll(_extractPrompts('Family & Kids', {
      'Family Portrait': FamilyKidsPrompts.getPrompts('Family Portrait'),
      'Baby Newborn': FamilyKidsPrompts.getPrompts('Baby Newborn'),
      'Kids Children': FamilyKidsPrompts.getPrompts('Kids Children'),
      'Maternity Pregnancy': FamilyKidsPrompts.getPrompts('Maternity Pregnancy'),
      'Grandparents': FamilyKidsPrompts.getPrompts('Grandparents'),
      'Siblings': FamilyKidsPrompts.getPrompts('Siblings'),
    }));

    // 5. Festivals & Occasions
    all.addAll(_extractPrompts('Festivals & Occasions', {
      'Diwali': FestivalsOccasionsPrompts.getPrompts('Diwali'),
      'Holi': FestivalsOccasionsPrompts.getPrompts('Holi'),
      'Eid': FestivalsOccasionsPrompts.getPrompts('Eid'),
      'Christmas': FestivalsOccasionsPrompts.getPrompts('Christmas'),
      'Birthday': FestivalsOccasionsPrompts.getPrompts('Birthday'),
      'Independence Day': FestivalsOccasionsPrompts.getPrompts('Independence Day'),
    }));

    // 6. Business & Marketing
    all.addAll(_extractPrompts('Business & Marketing', {
      'Logo Design': BusinessMarketingPrompts.getPrompts('Logo Design'),
      'Business Poster': BusinessMarketingPrompts.getPrompts('Business Poster'),
      'Social Ads': BusinessMarketingPrompts.getPrompts('Social Ads'),
      'Presentation': BusinessMarketingPrompts.getPrompts('Presentation'),
      'Office Corporate': BusinessMarketingPrompts.getPrompts('Office Corporate'),
      'Team Photos': BusinessMarketingPrompts.getPrompts('Team Photos'),
    }));

    // 7. Product & E-commerce
    all.addAll(_extractPrompts('Product & E-commerce', {
      'Electronics Gadgets': ProductEcommercePrompts.getPrompts('Electronics Gadgets'),
      'Fashion Apparel': ProductEcommercePrompts.getPrompts('Fashion Apparel'),
      'Beauty Cosmetics': ProductEcommercePrompts.getPrompts('Beauty Cosmetics'),
      'Jewelry Watches': ProductEcommercePrompts.getPrompts('Jewelry Watches'),
      'Home Furniture': ProductEcommercePrompts.getPrompts('Home Furniture'),
      'Packaging Design': ProductEcommercePrompts.getPrompts('Packaging Design'),
    }));

    // 8. Art Styles
    all.addAll(_extractPrompts('Art Styles', {
      'Photorealistic': ArtStylesPrompts.getPrompts('Photorealistic'),
      'Anime Manga': ArtStylesPrompts.getPrompts('Anime Manga'),
      '3D Render': ArtStylesPrompts.getPrompts('3D Render'),
      'Watercolor': ArtStylesPrompts.getPrompts('Watercolor'),
      'Oil Painting': ArtStylesPrompts.getPrompts('Oil Painting'),
      'Pixel Art': ArtStylesPrompts.getPrompts('Pixel Art'),
    }));

    // 9. Nature & Landscapes
    all.addAll(_extractPrompts('Nature & Landscapes', {
      'Mountains': NatureLandscapesPrompts.getPrompts('Mountains'),
      'Beach Ocean': NatureLandscapesPrompts.getPrompts('Beach Ocean'),
      'Forest Jungle': NatureLandscapesPrompts.getPrompts('Forest Jungle'),
      'Sunset Sunrise': NatureLandscapesPrompts.getPrompts('Sunset Sunrise'),
      'Waterfall River': NatureLandscapesPrompts.getPrompts('Waterfall River'),
      'Night Sky Stars': NatureLandscapesPrompts.getPrompts('Night Sky Stars'),
    }));

    // 10. Animals & Pets
    all.addAll(_extractPrompts('Animals & Pets', {
      'Dogs Puppies': AnimalsPetsPrompts.getPrompts('Dogs Puppies'),
      'Cats Kittens': AnimalsPetsPrompts.getPrompts('Cats Kittens'),
      'Birds': AnimalsPetsPrompts.getPrompts('Birds'),
      'Wildlife': AnimalsPetsPrompts.getPrompts('Wildlife'),
      'Pet Portraits': AnimalsPetsPrompts.getPrompts('Pet Portraits'),
      'Cute Animals': AnimalsPetsPrompts.getPrompts('Cute Animals'),
    }));

    // 11. Food & Restaurant
    all.addAll(_extractPrompts('Food & Restaurant', {
      'Indian Cuisine': FoodRestaurantPrompts.getPrompts('Indian Cuisine'),
      'Fast Food': FoodRestaurantPrompts.getPrompts('Fast Food'),
      'Desserts Sweets': FoodRestaurantPrompts.getPrompts('Desserts Sweets'),
      'Coffee Cafe': FoodRestaurantPrompts.getPrompts('Coffee Cafe'),
      'Restaurant Setup': FoodRestaurantPrompts.getPrompts('Restaurant Setup'),
      'Chef Cooking': FoodRestaurantPrompts.getPrompts('Chef Cooking'),
    }));

    // 12. Fashion & Lifestyle
    all.addAll(_extractPrompts('Fashion & Lifestyle', {
      'High Fashion': FashionLifestylePrompts.getPrompts('High Fashion'),
      'Street Style': FashionLifestylePrompts.getPrompts('Street Style'),
      'Indian Ethnic': FashionLifestylePrompts.getPrompts('Indian Ethnic'),
      'Fitness Gym': FashionLifestylePrompts.getPrompts('Fitness Gym'),
      'Beauty Makeup': FashionLifestylePrompts.getPrompts('Beauty Makeup'),
      'Accessories': FashionLifestylePrompts.getPrompts('Accessories'),
    }));

    // 13. Vehicles & Travel
    all.addAll(_extractPrompts('Vehicles & Travel', {
      'Sports Cars': VehiclesTravelPrompts.getPrompts('Sports Cars'),
      'Motorcycles': VehiclesTravelPrompts.getPrompts('Motorcycles'),
      'Travel India': VehiclesTravelPrompts.getPrompts('Travel India'),
      'World Travel': VehiclesTravelPrompts.getPrompts('World Travel'),
      'Adventure': VehiclesTravelPrompts.getPrompts('Adventure'),
      'Hotels Resorts': VehiclesTravelPrompts.getPrompts('Hotels Resorts'),
    }));

    // 14. Social Media
    all.addAll(_extractPrompts('Social Media', {
      'Instagram Post': SocialMediaPrompts.getPrompts('Instagram Post'),
      'YouTube Thumbnail': SocialMediaPrompts.getPrompts('YouTube Thumbnail'),
      'Reels Cover': SocialMediaPrompts.getPrompts('Reels Cover'),
      'Quote Posts': SocialMediaPrompts.getPrompts('Quote Posts'),
      'Story Templates': SocialMediaPrompts.getPrompts('Story Templates'),
      'Meme Templates': SocialMediaPrompts.getPrompts('Meme Templates'),
    }));

    // 15. Photo Enhancement
    all.addAll(_extractPrompts('Photo Enhancement', {
      'Upscale HD': PhotoEnhancementPrompts.getPrompts('Upscale HD'),
      'Old Photo Restore': PhotoEnhancementPrompts.getPrompts('Old Photo Restore'),
      'Background Remove': PhotoEnhancementPrompts.getPrompts('Background Remove'),
      'Face Enhance': PhotoEnhancementPrompts.getPrompts('Face Enhance'),
      'Color Correction': PhotoEnhancementPrompts.getPrompts('Color Correction'),
      'Style Transfer': PhotoEnhancementPrompts.getPrompts('Style Transfer'),
    }));

    // 16. AI Tools & Platforms
    all.addAll(_extractPrompts('AI Tools & Platforms', {
      'Midjourney': AIToolsPlatformsPrompts.getPrompts('Midjourney'),
      'DALL-E 3': AIToolsPlatformsPrompts.getPrompts('DALL-E 3'),
      'Stable Diffusion': AIToolsPlatformsPrompts.getPrompts('Stable Diffusion'),
      'Leonardo AI': AIToolsPlatformsPrompts.getPrompts('Leonardo AI'),
      'Kling Runway': AIToolsPlatformsPrompts.getPrompts('Kling Runway'),
      'Flux Ideogram': AIToolsPlatformsPrompts.getPrompts('Flux Ideogram'),
    }));

    return all;
  }

  /// Helper to extract prompts from subcategory map
  List<Map<String, dynamic>> _extractPrompts(
      String categoryName,
      Map<String, dynamic> subcategoryMap,
      ) {
    List<Map<String, dynamic>> extracted = [];

    subcategoryMap.forEach((subcategoryName, prompts) {
      if (prompts is List) {
        for (var p in prompts) {
          if (p is Map) {
            extracted.add({
              'title': p['title']?.toString() ?? '',
              'text': p['text'] ?? '',
              'description': p['description'] ?? '',
              'platform': p['platform'] ?? '',
              'category': categoryName,
              'subcategory': subcategoryName,
              'isFeatured': p['isFeatured']?.toString() ?? 'false',
              'isVideo': p['isVideo'] ?? false,
            });
          }
        }
      }
    });

    return extracted;
  }
}
