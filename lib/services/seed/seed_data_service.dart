// lib/services/seed/seed_data_service.dart

import 'dart:convert';
import 'package:flutter/services.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'category_data.dart';
import 'subcategory_data.dart';
import 'prompts/portrait_headshots_prompts.dart';
import 'prompts/couple_romance_prompts.dart';
import 'prompts/wedding_marriage_prompts.dart';
import 'prompts/family_kids_prompts.dart';
import 'prompts/festivals_occasions_prompts.dart';
import 'prompts/business_marketing_prompts.dart';
import 'prompts/product_ecommerce_prompts.dart';
import 'prompts/art_styles_prompts.dart';
import 'prompts/nature_landscapes_prompts.dart';
import 'prompts/animals_pets_prompts.dart';
import 'prompts/food_restaurant_prompts.dart';
import 'prompts/fashion_lifestyle_prompts.dart';
import 'prompts/vehicles_travel_prompts.dart';
import 'prompts/social_media_prompts.dart';
import 'prompts/photo_enhancement_prompts.dart';
import 'prompts/ai_tools_platforms_prompts.dart';
import 'prompts/gaming_esports_prompts.dart';
import 'prompts/architecture_interiors_prompts.dart';

class SeedDataService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  final Map<String, String> _generatedImageMap = {};
  final Map<String, String> _generatedVideoMap = {};

  String _normalize(String text) => text.trim().toLowerCase();

  Future<void> seedAllData({required Function(String) onProgress}) async {
    onProgress('📥 Loading Media Assets...');
    await _loadGeneratedMedia();

    onProgress('🧹 Wiping Database for fresh start...');
    await _cleanDatabase();

    final categories = CategoryData.getAllCategories();
    int totalPromptsCount = 0;
    int linkedCount = 0;

    for (int i = 0; i < categories.length; i++) {
      final cat = categories[i];
      final catName = cat['name']!;
      
      onProgress('📁 Seeding: $catName (${i + 1}/${categories.length})');

      // 1. Calculate category-wide prompt count first
      final subs = SubcategoryData.getSubcategories(catName);
      int catTotalPrompts = 0;
      for (var sub in subs) {
        catTotalPrompts += _getPrompts(catName, sub['name']!).length;
      }

      // 2. Create Category with count included (avoiding .update later)
      final catRef = await _db.collection('categories').add({
        'name': catName,
        'icon': cat['icon'],
        'color': cat['color'],
        'order': i,
        'promptCount': catTotalPrompts,
        'createdAt': FieldValue.serverTimestamp(),
        'description': cat['description'] ?? '',
      });

      for (int s = 0; s < subs.length; s++) {
        final sub = subs[s];
        final subName = sub['name']!;
        final subPrompts = _getPrompts(catName, subName);

        // 3. Create Subcategory with count included
        final subRef = await catRef.collection('subcategories').add({
          'name': subName,
          'icon': sub['icon'],
          'order': s,
          'promptCount': subPrompts.length,
          'categoryId': catRef.id,
          'categoryName': catName,
        });

        // 4. Seed Prompts
        for (final p in subPrompts) {
          final String title = p['title']?.toString() ?? '';
          final String normalizedTitle = _normalize(title);
          
          String cloudImageUrl = _generatedImageMap[normalizedTitle] ?? '';
          String cloudVideoUrl = _generatedVideoMap[normalizedTitle] ?? '';
          
          String exampleType = 'none';
          if (cloudVideoUrl.isNotEmpty) {
            exampleType = 'video';
          } else if (cloudImageUrl.isNotEmpty) {
            exampleType = 'image';
          }

          if (cloudImageUrl.isNotEmpty) linkedCount++;

          await _db.collection('prompts').add({
            'title': title,
            'text': p['text'],
            'platform': p['platform'],
            'description': p['description'] ?? '',
            'categoryId': catRef.id,
            'subcategoryId': subRef.id,
            'categoryName': catName,
            'subcategoryName': subName,
            'createdAt': FieldValue.serverTimestamp(),
            'hasExample': cloudImageUrl.isNotEmpty || cloudVideoUrl.isNotEmpty,
            'exampleType': exampleType,
            'exampleImageUrl': cloudImageUrl, 
            'exampleVideoUrl': cloudVideoUrl, 
            'thumbnailUrl': cloudImageUrl,    
            'platformKey': _getPlatformKey(p['platform']?.toString() ?? 'Other'),
            'platformUrl': _getPlatformUrl(p['platform']?.toString() ?? 'Other'),
            'isFeatured': p['isFeatured']?.toString() == 'true',
            'tags': _extractTags(p),
            'usageCount': 0,
          });
        }
        totalPromptsCount += subPrompts.length;
      }
    }

    onProgress('🎉 SEEDING COMPLETE! $totalPromptsCount prompts uploaded.');
  }

  Future<void> _loadGeneratedMedia() async {
    try {
      final String imageContents = await rootBundle.loadString('assets/generated_images.json');
      final dynamic decodedImages = jsonDecode(imageContents);
      final Map<String, dynamic> imageData = _convertToMap(decodedImages);

      imageData.forEach((key, item) {
        String titleKey = _normalize(item['title'] ?? '');
        String imageUrl = item['cloudinaryUrl'] ?? '';
        String videoUrl = item['videoUrl'] ?? '';
        if (titleKey.isNotEmpty) {
          if (imageUrl.isNotEmpty) _generatedImageMap[titleKey] = imageUrl;
          if (videoUrl.isNotEmpty) _generatedVideoMap[titleKey] = videoUrl;
        }
      });
    } catch (e) {}
  }

  Map<String, dynamic> _convertToMap(dynamic decoded) {
    if (decoded is Map<String, dynamic>) return decoded;
    if (decoded is List) {
      final Map<String, dynamic> map = {};
      for (var item in decoded) {
        if (item is Map && item.containsKey('title')) {
          map[item['title']] = item;
        }
      }
      return map;
    }
    return {};
  }

  Future<void> _cleanDatabase() async {
    // Delete prompts
    final promptSnap = await _db.collection('prompts').get();
    for (var doc in promptSnap.docs) await doc.reference.delete();
    
    // Delete categories and their subcollections
    final catSnap = await _db.collection('categories').get();
    for (var catDoc in catSnap.docs) {
      final subSnap = await catDoc.reference.collection('subcategories').get();
      for (var subDoc in subSnap.docs) await subDoc.reference.delete();
      await catDoc.reference.delete();
    }
  }

  List<Map<String, dynamic>> _getPrompts(String category, String subcategory) {
    switch (category) {
      case 'Portrait & Headshots': return PortraitHeadshotsPrompts.getPrompts(subcategory).map((e) => Map<String, dynamic>.from(e)).toList();
      case 'Couple & Romance': return CoupleRomancePrompts.getPrompts(subcategory).map((e) => Map<String, dynamic>.from(e)).toList();
      case 'Wedding & Marriage': return WeddingMarriagePrompts.getPrompts(subcategory).map((e) => Map<String, dynamic>.from(e)).toList();
      case 'Family & Kids': return FamilyKidsPrompts.getPrompts(subcategory).map((e) => Map<String, dynamic>.from(e)).toList();
      case 'Festivals & Occasions': return FestivalsOccasionsPrompts.getPrompts(subcategory).map((e) => Map<String, dynamic>.from(e)).toList();
      case 'Business & Marketing': return BusinessMarketingPrompts.getPrompts(subcategory).map((e) => Map<String, dynamic>.from(e)).toList();
      case 'Product & E-commerce': return ProductEcommercePrompts.getPrompts(subcategory).map((e) => Map<String, dynamic>.from(e)).toList();
      case 'Art Styles': return ArtStylesPrompts.getPrompts(subcategory).map((e) => Map<String, dynamic>.from(e)).toList();
      case 'Nature & Landscapes': return NatureLandscapesPrompts.getPrompts(subcategory).map((e) => Map<String, dynamic>.from(e)).toList();
      case 'Animals & Pets': return AnimalsPetsPrompts.getPrompts(subcategory).map((e) => Map<String, dynamic>.from(e)).toList();
      case 'Food & Restaurant': return FoodRestaurantPrompts.getPrompts(subcategory).map((e) => Map<String, dynamic>.from(e)).toList();
      case 'Fashion & Lifestyle': return FashionLifestylePrompts.getPrompts(subcategory).map((e) => Map<String, dynamic>.from(e)).toList();
      case 'Vehicles & Travel': return VehiclesTravelPrompts.getPrompts(subcategory).map((e) => Map<String, dynamic>.from(e)).toList();
      case 'Social Media': return SocialMediaPrompts.getPrompts(subcategory).map((e) => Map<String, dynamic>.from(e)).toList();
      case 'Photo Enhancement': return PhotoEnhancementPrompts.getPrompts(subcategory).map((e) => Map<String, dynamic>.from(e)).toList();
      case 'AI Tools & Platforms': return AIToolsPlatformsPrompts.getPrompts(subcategory).map((e) => Map<String, dynamic>.from(e)).toList();
      case 'Gaming & Esports': return GamingEsportsPrompts.getPrompts(subcategory).map((e) => Map<String, dynamic>.from(e)).toList();
      case 'Architecture & Interiors': return ArchitectureInteriorsPrompts.getPrompts(subcategory).map((e) => Map<String, dynamic>.from(e)).toList();
      default: return [];
    }
  }

  String _getPlatformKey(String platform) {
    const keys = {'Midjourney': 'midjourney', 'Leonardo AI': 'leonardo', 'DALL-E 3': 'dalle', 'Stable Diffusion XL': 'sdxl', 'Ideogram': 'ideogram', 'Kling AI': 'kling', 'Runway ML': 'runway', 'Adobe Firefly': 'firefly', 'Sora': 'sora', 'Gemini AI': 'gemini', 'Luma AI': 'luma', 'Pika Labs': 'pika', 'Flux AI': 'flux'};
    return keys[platform] ?? 'other';
  }

  String _getPlatformUrl(String platform) {
    const urls = {'midjourney': 'https://midjourney.com', 'leonardo': 'https://leonardo.ai', 'dalle': 'https://openai.com/dall-e-3', 'sdxl': 'https://stability.ai', 'ideogram': 'https://ideogram.ai', 'kling': 'https://klingai.com', 'runway': 'https://runwayml.com', 'firefly': 'https://firefly.adobe.com', 'sora': 'https://openai.com/sora', 'gemini': 'https://gemini.google.com', 'luma': 'https://lumalabs.ai', 'pika': 'https://pika.art', 'flux': 'https://flux.ai'};
    return urls[_getPlatformKey(platform)] ?? '';
  }

  List<String> _extractTags(Map<String, dynamic> p) {
    final words = '${p['title']} ${p['description']}'.toLowerCase().split(RegExp(r'[\s,]+')).where((w) => w.length > 3).toSet().take(6).toList();
    return words;
  }
}
