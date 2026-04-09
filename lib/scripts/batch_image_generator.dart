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
import '../services/seed/prompts/gaming_esports_prompts.dart';
import '../services/seed/prompts/architecture_interiors_prompts.dart';

class BatchImageGenerator {
  final MediaGeneratorService _mediaService = MediaGeneratorService();

  static const int DELAY_SECONDS = 3; 

  Future<void> generateAllImages() async {
    print('═══════════════════════════════════════════════════════════');
    print('🎨 AI IMAGE BATCH GENERATOR');
    print('═══════════════════════════════════════════════════════════\n');

    Map<String, dynamic> generatedResults = await _loadExistingProgress();
    final allPrompts = _getAllPrompts();

    print('📊 Total prompts in library: ${allPrompts.length}');
    print('📊 Total entries in JSON:    ${generatedResults.length}');
    
    int successCount = 0;
    int skippedCount = 0;
    int failedCount = 0;

    for (int i = 0; i < allPrompts.length; i++) {
      final item = allPrompts[i];
      final title = item['title']?.toString() ?? '';
      final category = item['category']?.toString() ?? '';
      final subcategory = item['subcategory']?.toString() ?? '';
      final promptText = item['text']?.toString() ?? '';

      // ✅ FIX: Only skip if the title exists AND has a valid URL
      if (generatedResults.containsKey(title)) {
        final existingUrl = generatedResults[title]['cloudinaryUrl']?.toString() ?? '';
        if (existingUrl.isNotEmpty && existingUrl.startsWith('http')) {
          skippedCount++;
          continue;
        }
      }

      print('\n[${i + 1}/${allPrompts.length}] 📸 Processing: $title');
      print('   Category: $category > $subcategory');

      try {
        String url = await _mediaService.generateImage(
          promptText: promptText,
          title: title,
          category: category,
        );

        if (url.isNotEmpty) {
          generatedResults[title] = {
            "title": title,
            "category": category,
            "subcategory": subcategory,
            "platform": item['platform'],
            "cloudinaryUrl": url,
            "isFeatured": item['isFeatured'],
          };

          await _saveProgress(generatedResults);
          successCount++;
          print('   ✅ Saved URL to JSON');
        } else {
          failedCount++;
          print('   ❌ Failed: Empty URL');
        }

        await Future.delayed(Duration(seconds: DELAY_SECONDS));
      } catch (e) {
        failedCount++;
        print('   ❌ Error: $e');
      }
    }

    print('\n═══════════════════════════════════════════════════════════');
    print('🏁 FINISHED');
    print('   ✅ Newly Generated: $successCount');
    print('   ⏩ Already Existed:  $skippedCount');
    print('   ❌ Failed:           $failedCount');
    print('═══════════════════════════════════════════════════════════\n');
  }

  Future<Map<String, dynamic>> _loadExistingProgress() async {
    try {
      final file = File('assets/generated_images.json'); // Pointing to correct asset path
      if (await file.exists()) {
        final content = await file.readAsString();
        return Map<String, dynamic>.from(jsonDecode(content));
      }
    } catch (_) {}
    return {};
  }

  Future<void> _saveProgress(Map<String, dynamic> data) async {
    final file = File('assets/generated_images.json');
    await file.writeAsString(JsonEncoder.withIndent('  ').convert(data));
  }

  List<Map<String, dynamic>> _getAllPrompts() {
    List<Map<String, dynamic>> all = [];
    
    all.addAll(_extractPrompts('Portrait & Headshots', {
      'LinkedIn Professional': PortraitHeadshotsPrompts.getPrompts('LinkedIn Professional'),
      'Dating Profile': PortraitHeadshotsPrompts.getPrompts('Dating Profile'),
      'Corporate Business': PortraitHeadshotsPrompts.getPrompts('Corporate Business'),
      'Creative Artistic': PortraitHeadshotsPrompts.getPrompts('Creative Artistic'),
      'Actor Model Portfolio': PortraitHeadshotsPrompts.getPrompts('Actor Model Portfolio'),
      'Student Graduate': PortraitHeadshotsPrompts.getPrompts('Student Graduate'),
    }));

    all.addAll(_extractPrompts('Couple & Romance', {
      'Valentine Special': CoupleRomancePrompts.getPrompts('Valentine Special'),
      'Engagement Proposal': CoupleRomancePrompts.getPrompts('Engagement Proposal'),
      'Couple Photoshoot': CoupleRomancePrompts.getPrompts('Couple Photoshoot'),
      'Pre-Wedding': CoupleRomancePrompts.getPrompts('Pre-Wedding'),
      'Anniversary': CoupleRomancePrompts.getPrompts('Anniversary'),
      'Romantic Scenes': CoupleRomancePrompts.getPrompts('Romantic Scenes'),
    }));

    all.addAll(_extractPrompts('Wedding & Marriage', {
      'Bridal Portraits': WeddingMarriagePrompts.getPrompts('Bridal Portraits'),
      'Groom Portraits': WeddingMarriagePrompts.getPrompts('Groom Portraits'),
      'Haldi Ceremony': WeddingMarriagePrompts.getPrompts('Haldi Ceremony'),
      'Mehndi Function': WeddingMarriagePrompts.getPrompts('Mehndi Function'),
      'Wedding Ceremony': WeddingMarriagePrompts.getPrompts('Wedding Ceremony'),
      'Reception Party': WeddingMarriagePrompts.getPrompts('Reception Party'),
    }));

    all.addAll(_extractPrompts('Family & Kids', {
      'Family Portrait': FamilyKidsPrompts.getPrompts('Family Portrait'),
      'Baby Newborn': FamilyKidsPrompts.getPrompts('Baby Newborn'),
      'Kids Children': FamilyKidsPrompts.getPrompts('Kids Children'),
      'Maternity Pregnancy': FamilyKidsPrompts.getPrompts('Maternity Pregnancy'),
      'Grandparents': FamilyKidsPrompts.getPrompts('Grandparents'),
      'Siblings': FamilyKidsPrompts.getPrompts('Siblings'),
    }));

    all.addAll(_extractPrompts('Festivals & Occasions', {
      'Diwali': FestivalsOccasionsPrompts.getPrompts('Diwali'),
      'Holi': FestivalsOccasionsPrompts.getPrompts('Holi'),
      'Eid': FestivalsOccasionsPrompts.getPrompts('Eid'),
      'Christmas': FestivalsOccasionsPrompts.getPrompts('Christmas'),
      'Birthday': FestivalsOccasionsPrompts.getPrompts('Birthday'),
      'Independence Day': FestivalsOccasionsPrompts.getPrompts('Independence Day'),
    }));

    all.addAll(_extractPrompts('Business & Marketing', {
      'Logo Design': BusinessMarketingPrompts.getPrompts('Logo Design'),
      'Business Poster': BusinessMarketingPrompts.getPrompts('Business Poster'),
      'Social Ads': BusinessMarketingPrompts.getPrompts('Social Ads'),
      'Presentation': BusinessMarketingPrompts.getPrompts('Presentation'),
      'Office Corporate': BusinessMarketingPrompts.getPrompts('Office Corporate'),
      'Team Photos': BusinessMarketingPrompts.getPrompts('Team Photos'),
    }));

    all.addAll(_extractPrompts('Product & E-commerce', {
      'Electronics Gadgets': ProductEcommercePrompts.getPrompts('Electronics Gadgets'),
      'Fashion Apparel': ProductEcommercePrompts.getPrompts('Fashion Apparel'),
      'Beauty Cosmetics': ProductEcommercePrompts.getPrompts('Beauty Cosmetics'),
      'Jewelry Watches': ProductEcommercePrompts.getPrompts('Jewelry Watches'),
      'Home Furniture': ProductEcommercePrompts.getPrompts('Home Furniture'),
      'Packaging Design': ProductEcommercePrompts.getPrompts('Packaging Design'),
    }));

    all.addAll(_extractPrompts('Art Styles', {
      'Photorealistic': ArtStylesPrompts.getPrompts('Photorealistic'),
      'Anime Manga': ArtStylesPrompts.getPrompts('Anime Manga'),
      '3D Render': ArtStylesPrompts.getPrompts('3D Render'),
      'Watercolor': ArtStylesPrompts.getPrompts('Watercolor'),
      'Oil Painting': ArtStylesPrompts.getPrompts('Oil Painting'),
      'Pixel Art': ArtStylesPrompts.getPrompts('Pixel Art'),
    }));

    all.addAll(_extractPrompts('Nature & Landscapes', {
      'Mountains': NatureLandscapesPrompts.getPrompts('Mountains'),
      'Beach Ocean': NatureLandscapesPrompts.getPrompts('Beach Ocean'),
      'Forest Jungle': NatureLandscapesPrompts.getPrompts('Forest Jungle'),
      'Sunset Sunrise': NatureLandscapesPrompts.getPrompts('Sunset Sunrise'),
      'Waterfall River': NatureLandscapesPrompts.getPrompts('Waterfall River'),
      'Night Sky Stars': NatureLandscapesPrompts.getPrompts('Night Sky Stars'),
    }));

    all.addAll(_extractPrompts('Animals & Pets', {
      'Dogs Puppies': AnimalsPetsPrompts.getPrompts('Dogs Puppies'),
      'Cats Kittens': AnimalsPetsPrompts.getPrompts('Cats Kittens'),
      'Birds': AnimalsPetsPrompts.getPrompts('Birds'),
      'Wildlife': AnimalsPetsPrompts.getPrompts('Wildlife'),
      'Pet Portraits': AnimalsPetsPrompts.getPrompts('Pet Portraits'),
      'Cute Animals': AnimalsPetsPrompts.getPrompts('Cute Animals'),
    }));

    all.addAll(_extractPrompts('Food & Restaurant', {
      'Indian Cuisine': FoodRestaurantPrompts.getPrompts('Indian Cuisine'),
      'Fast Food': FoodRestaurantPrompts.getPrompts('Fast Food'),
      'Desserts Sweets': FoodRestaurantPrompts.getPrompts('Desserts Sweets'),
      'Coffee Cafe': FoodRestaurantPrompts.getPrompts('Coffee Cafe'),
      'Restaurant Setup': FoodRestaurantPrompts.getPrompts('Restaurant Setup'),
      'Chef Cooking': FoodRestaurantPrompts.getPrompts('Chef Cooking'),
    }));

    all.addAll(_extractPrompts('Fashion & Lifestyle', {
      'High Fashion': FashionLifestylePrompts.getPrompts('High Fashion'),
      'Street Style': FashionLifestylePrompts.getPrompts('Street Style'),
      'Indian Ethnic': FashionLifestylePrompts.getPrompts('Indian Ethnic'),
      'Fitness Gym': FashionLifestylePrompts.getPrompts('Fitness Gym'),
      'Beauty Makeup': FashionLifestylePrompts.getPrompts('Beauty Makeup'),
      'Accessories': FashionLifestylePrompts.getPrompts('Accessories'),
    }));

    all.addAll(_extractPrompts('Vehicles & Travel', {
      'Sports Cars': VehiclesTravelPrompts.getPrompts('Sports Cars'),
      'Motorcycles': VehiclesTravelPrompts.getPrompts('Motorcycles'),
      'Travel India': VehiclesTravelPrompts.getPrompts('Travel India'),
      'World Travel': VehiclesTravelPrompts.getPrompts('World Travel'),
      'Adventure': VehiclesTravelPrompts.getPrompts('Adventure'),
      'Hotels Resorts': VehiclesTravelPrompts.getPrompts('Hotels Resorts'),
    }));

    all.addAll(_extractPrompts('Social Media', {
      'Instagram Post': SocialMediaPrompts.getPrompts('Instagram Post'),
      'YouTube Thumbnail': SocialMediaPrompts.getPrompts('YouTube Thumbnail'),
      'Reels Cover': SocialMediaPrompts.getPrompts('Reels Cover'),
      'Quote Posts': SocialMediaPrompts.getPrompts('Quote Posts'),
      'Story Templates': SocialMediaPrompts.getPrompts('Story Templates'),
      'Meme Templates': SocialMediaPrompts.getPrompts('Meme Templates'),
    }));

    all.addAll(_extractPrompts('Photo Enhancement', {
      'Upscale HD': PhotoEnhancementPrompts.getPrompts('Upscale HD'),
      'Old Photo Restore': PhotoEnhancementPrompts.getPrompts('Old Photo Restore'),
      'Background Remove': PhotoEnhancementPrompts.getPrompts('Background Remove'),
      'Face Enhance': PhotoEnhancementPrompts.getPrompts('Face Enhance'),
      'Color Correction': PhotoEnhancementPrompts.getPrompts('Color Correction'),
      'Style Transfer': PhotoEnhancementPrompts.getPrompts('Style Transfer'),
    }));

    all.addAll(_extractPrompts('AI Tools & Platforms', {
      'Midjourney': AIToolsPlatformsPrompts.getPrompts('Midjourney'),
      'DALL-E 3': AIToolsPlatformsPrompts.getPrompts('DALL-E 3'),
      'Stable Diffusion': AIToolsPlatformsPrompts.getPrompts('Stable Diffusion'),
      'Leonardo AI': AIToolsPlatformsPrompts.getPrompts('Leonardo AI'),
      'Kling Runway': AIToolsPlatformsPrompts.getPrompts('Kling Runway'),
      'Flux Ideogram': AIToolsPlatformsPrompts.getPrompts('Flux Ideogram'),
    }));

    all.addAll(_extractPrompts('Gaming & Esports', {
      'Cyberpunk Hero': GamingEsportsPrompts.getPrompts('Cyberpunk Hero'),
      'Fantasy Warrior': GamingEsportsPrompts.getPrompts('Fantasy Warrior'),
      'Esports Streamer': GamingEsportsPrompts.getPrompts('Esports Streamer'),
      'GTA Style Avatar': GamingEsportsPrompts.getPrompts('GTA Style Avatar'),
      '3D Game Character': GamingEsportsPrompts.getPrompts('3D Game Character'),
      'Superhero Suit': GamingEsportsPrompts.getPrompts('Superhero Suit'),
    }));

    all.addAll(_extractPrompts('Architecture & Interiors', {
      'Luxury Penthouse': ArchitectureInteriorsPrompts.getPrompts('Luxury Penthouse'),
      'Executive Office': ArchitectureInteriorsPrompts.getPrompts('Executive Office'),
      'Dream Home Life': ArchitectureInteriorsPrompts.getPrompts('Dream Home Life'),
      'Vintage Royal Hall': ArchitectureInteriorsPrompts.getPrompts('Vintage Royal Hall'),
      'Creative Studio': ArchitectureInteriorsPrompts.getPrompts('Creative Studio'),
      'Outdoor Balcony': ArchitectureInteriorsPrompts.getPrompts('Outdoor Balcony'),
    }));

    return all;
  }

  List<Map<String, dynamic>> _extractPrompts(String categoryName, Map<String, dynamic> subMap) {
    List<Map<String, dynamic>> list = [];
    subMap.forEach((subName, prompts) {
      if (prompts is List) {
        for (var p in prompts) {
          list.add({
            ...Map<String, dynamic>.from(p),
            'category': categoryName,
            'subcategory': subName,
          });
        }
      }
    });
    return list;
  }
}

void main() async {
  await BatchImageGenerator().generateAllImages();
}
