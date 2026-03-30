// lib/providers/prompt_provider.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/prompt_model.dart';
import '../models/subcategory_model.dart';
import '../services/local_storage_service.dart';

class PromptProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  // ─── FAVORITES ───
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

  // ─── SEARCH ───
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

  // ─── CATEGORIES STREAM ───
  Stream<List<CategoryModel>> get categoriesStream {
    return _firestore
        .collection('categories')
        .orderBy('order')
        .snapshots()
        .map((snap) => snap.docs.map((d) => CategoryModel.fromDoc(d)).toList());
  }

  // ─── ALL PROMPTS STREAM ───
  Stream<List<PromptModel>> get promptsStream {
    return _firestore
        .collection('prompts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => PromptModel.fromDoc(d)).toList());
  }

  // ─── TRENDING PROMPTS STREAM ───
  Stream<List<PromptModel>> get trendingPromptsStream {
    return _firestore
        .collection('prompts')
        .orderBy('usageCount', descending: true)
        .limit(50)
        .snapshots()
        .map((snap) => snap.docs.map((d) => PromptModel.fromDoc(d)).toList());
  }

  // ─── SUBCATEGORIES STREAM ───
  Stream<List<SubcategoryModel>> subcategoriesStream(String categoryId) {
    return _firestore
        .collection('categories')
        .doc(categoryId)
        .collection('subcategories')
        .orderBy('order')
        .snapshots()
        .map((snap) => snap.docs.map((d) => SubcategoryModel.fromDoc(d)).toList());
  }

  // ─── PROMPTS BY USER INTERESTS ───
  Stream<List<PromptModel>> getPromptsForInterests(List<String> interestIds) {
    if (interestIds.isEmpty) {
      return trendingPromptsStream;
    }

    return _firestore
        .collection('prompts')
        .where('categoryId', whereIn: interestIds.take(10).toList())
        .orderBy('usageCount', descending: true)
        .limit(30)
        .snapshots()
        .map((snap) => snap.docs.map((d) => PromptModel.fromDoc(d)).toList());
  }

  // ─── CATEGORIES BY USER INTERESTS ───
  Stream<List<CategoryModel>> getCategoriesForInterests(List<String> interestIds) {
    if (interestIds.isEmpty) {
      return categoriesStream;
    }

    return _firestore
        .collection('categories')
        .where(FieldPath.documentId, whereIn: interestIds.take(10).toList())
        .snapshots()
        .map((snap) => snap.docs.map((d) => CategoryModel.fromDoc(d)).toList());
  }

  // ─── PROMPTS BY CATEGORY ───
  Stream<List<PromptModel>> getPromptsByCategory(String categoryId) {
    return _firestore
        .collection('prompts')
        .where('categoryId', isEqualTo: categoryId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => PromptModel.fromDoc(d)).toList());
  }

  // ─── PROMPTS BY SUBCATEGORY ───
  Stream<List<PromptModel>> promptsBySubcategory(String categoryId, String subcategoryId) {
    return _firestore
        .collection('prompts')
        .where('categoryId', isEqualTo: categoryId)
        .where('subcategoryId', isEqualTo: subcategoryId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => PromptModel.fromDoc(d)).toList());
  }

  // ─── INCREMENT USAGE COUNT ───
  Future<void> incrementUsageCount(String promptId) async {
    await _firestore.collection('prompts').doc(promptId).update({
      'usageCount': FieldValue.increment(1),
    });
  }

  // ─── SEARCH ───
  Future<List<PromptModel>> searchPrompts(String query) async {
    final lowerQuery = query.toLowerCase();
    final snap = await _firestore.collection('prompts').get();
    return snap.docs
        .map((d) => PromptModel.fromDoc(d))
        .where((p) =>
            p.title.toLowerCase().contains(lowerQuery) ||
            p.description.toLowerCase().contains(lowerQuery) ||
            p.text.toLowerCase().contains(lowerQuery))
        .toList();
  }

  Future<void> clearFavorites() async {
    await LocalStorageService.clearFavorites();
    _favoriteIds.clear();
    notifyListeners();
  }
}
