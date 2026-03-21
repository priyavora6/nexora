import 'dart:math';

import 'package:flutter/material.dart';
import '../models/prompt_model.dart';
import '../models/category_model.dart';
import '../models/subcategory_model.dart';
import '../services/firestore_service.dart';
import '../services/local_storage_service.dart';

class PromptProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<String> _favoriteIds = [];
  List<String> _recentSearches = [];

  List<String> get favoriteIds => _favoriteIds;
  List<String> get recentSearches => _recentSearches;

  PromptProvider() {
    _loadLocalData();
  }

  Future<void> _loadLocalData() async {
    _favoriteIds = await LocalStorageService.getFavorites();
    _recentSearches = await LocalStorageService.getRecentSearches();
    notifyListeners();
  }

  // ══════════════════════════════════════════════
  // ⭐ FAVORITES
  // ══════════════════════════════════════════════

  bool isFavorite(String promptId) => _favoriteIds.contains(promptId);

  Future<void> toggleFavorite(String promptId) async {
    if (_favoriteIds.contains(promptId)) {
      await LocalStorageService.removeFavorite(promptId);
      _favoriteIds.remove(promptId);
    } else {
      await LocalStorageService.addFavorite(promptId);
      _favoriteIds.add(promptId);
    }
    notifyListeners();
  }

  Future<void> clearFavorites() async {
    await LocalStorageService.clearFavorites();
    _favoriteIds.clear();
    notifyListeners();
  }

  // ══════════════════════════════════════════════
  // 🔍 SEARCH
  // ══════════════════════════════════════════════

  Future<void> addRecentSearch(String query) async {
    await LocalStorageService.addRecentSearch(query);
    _recentSearches = await LocalStorageService.getRecentSearches();
    notifyListeners();
  }

  Future<void> clearSearches() async {
    await LocalStorageService.clearRecentSearches();
    _recentSearches.clear();
    notifyListeners();
  }

  Future<List<PromptModel>> searchPrompts(String query) =>
      _firestoreService.searchPrompts(query);

  // ══════════════════════════════════════════════
  // 📁 CATEGORIES
  // ══════════════════════════════════════════════

  Stream<List<CategoryModel>> get categoriesStream =>
      _firestoreService.getCategories();

  // ══════════════════════════════════════════════
  // 📂 SUBCATEGORIES
  // ══════════════════════════════════════════════

  Stream<List<SubcategoryModel>> subcategoriesStream(String categoryId) =>
      _firestoreService.getSubcategories(categoryId);

  // ══════════════════════════════════════════════
  // 📝 PROMPTS
  // ══════════════════════════════════════════════

  Stream<List<PromptModel>> get promptsStream =>
      _firestoreService.getPrompts();

  Stream<List<PromptModel>> get recentPromptsStream =>
      _firestoreService.getRecentPrompts();

  Stream<List<PromptModel>> promptsByCategory(String categoryId) =>
      _firestoreService.getPromptsByCategory(categoryId);

  Stream<List<PromptModel>> promptsBySubcategory(
      String categoryId, String subcategoryId) =>
      _firestoreService.getPromptsBySubcategory(categoryId, subcategoryId);

  // ══════════════════════════════════════════════
  // 🔥 TRENDING PROMPTS (Changes Daily)
  // ══════════════════════════════════════════════

  Stream<List<PromptModel>> get trendingPromptsStream =>
      _firestoreService.getTrendingPrompts(limit: 5);
}