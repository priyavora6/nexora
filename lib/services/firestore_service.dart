import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category_model.dart';
import '../models/prompt_model.dart';
import '../models/subcategory_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ══════════════════════════════════════════════
  // 📁 CATEGORIES
  // ══════════════════════════════════════════════

  Stream<List<CategoryModel>> getCategories() {
    return _db
        .collection('categories')
        .orderBy('order')
        .snapshots()
        .map((snap) => snap.docs.map((d) => CategoryModel.fromDoc(d)).toList());
  }

  Stream<int> getCategoryCount() {
    return _db.collection('categories').snapshots().map((snap) => snap.docs.length);
  }

  Future<int> getTotalCategories() async {
    final snap = await _db.collection('categories').get();
    return snap.docs.length;
  }

  Future<String> addCategoryAndGetId(Map<String, dynamic> data) async {
    data['createdAt'] = FieldValue.serverTimestamp();
    final ref = await _db.collection('categories').add(data);
    return ref.id;
  }

  Future<void> addCategory(CategoryModel cat) async {
    await _db.collection('categories').add(cat.toFirestore());
  }

  Future<void> updateCategory(String id, Map<String, dynamic> data) async {
    await _db.collection('categories').doc(id).update(data);
  }

  Future<void> updateCategoryHeroExamples(
      String categoryId,
      List<String> heroExampleUrls,
      List<String> heroExampleTypes,
      ) async {
    await _db.collection('categories').doc(categoryId).update({
      'heroExampleUrls': heroExampleUrls,
      'heroExampleTypes': heroExampleTypes,
    });
  }

  Future<void> deleteCategory(String categoryId) async {
    final prompts = await _db
        .collection('prompts')
        .where('categoryId', isEqualTo: categoryId)
        .get();
    for (final doc in prompts.docs) {
      await doc.reference.delete();
    }

    final subs = await _db
        .collection('categories')
        .doc(categoryId)
        .collection('subcategories')
        .get();
    for (final doc in subs.docs) {
      await doc.reference.delete();
    }

    await _db.collection('categories').doc(categoryId).delete();
  }

  // ══════════════════════════════════════════════
  // 📂 SUBCATEGORIES
  // ══════════════════════════════════════════════

  Stream<List<SubcategoryModel>> getSubcategories(String categoryId) {
    return _db
        .collection('categories')
        .doc(categoryId)
        .collection('subcategories')
        .orderBy('order')
        .snapshots()
        .map((snap) =>
        snap.docs.map((d) => SubcategoryModel.fromDoc(d)).toList());
  }

  Future<List<SubcategoryModel>> getSubcategoriesList(
      String categoryId) async {
    final snap = await _db
        .collection('categories')
        .doc(categoryId)
        .collection('subcategories')
        .orderBy('order')
        .get();
    return snap.docs.map((d) => SubcategoryModel.fromDoc(d)).toList();
  }

  Future<void> addSubcategory(
      String categoryId, Map<String, dynamic> data) async {
    data['createdAt'] = FieldValue.serverTimestamp();
    await _db
        .collection('categories')
        .doc(categoryId)
        .collection('subcategories')
        .add(data);
  }

  Future<void> updateSubcategoryFeaturedExample(
      String categoryId,
      String subcategoryId,
      String? featuredExampleUrl,
      String? featuredExampleType,
      ) async {
    await _db
        .collection('categories')
        .doc(categoryId)
        .collection('subcategories')
        .doc(subcategoryId)
        .update({
      'featuredExampleUrl': featuredExampleUrl,
      'featuredExampleType': featuredExampleType,
    });
  }

  Future<void> deleteAllSubcategories(String categoryId) async {
    final subs = await _db
        .collection('categories')
        .doc(categoryId)
        .collection('subcategories')
        .get();
    for (final doc in subs.docs) {
      await doc.reference.delete();
    }
  }

  // ══════════════════════════════════════════════
  // 📝 PROMPTS
  // ══════════════════════════════════════════════

  Stream<List<PromptModel>> getPrompts() {
    return _db
        .collection('prompts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => PromptModel.fromDoc(d)).toList());
  }

  Stream<int> getPromptCount() {
    return _db.collection('prompts').snapshots().map((snap) => snap.docs.length);
  }

  Stream<List<PromptModel>> getRecentPrompts({int limit = 10}) {
    return _db
        .collection('prompts')
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snap) => snap.docs.map((d) => PromptModel.fromDoc(d)).toList());
  }

  Stream<List<PromptModel>> getPromptsByCategory(String categoryId) {
    return _db
        .collection('prompts')
        .where('categoryId', isEqualTo: categoryId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => PromptModel.fromDoc(d)).toList());
  }

  /// ➕ Get Prompts by Multiple Categories (for Curated Feed)
  Stream<List<PromptModel>> getPromptsByInterests(List<String> interests) {
    if (interests.isEmpty) return Stream.value([]);
    
    // Firestore whereIn is limited to 10 items
    final limitedInterests = interests.length > 10 ? interests.sublist(0, 10) : interests;

    return _db
        .collection('prompts')
        .where('categoryId', whereIn: limitedInterests)
        .orderBy('createdAt', descending: true)
        .limit(20)
        .snapshots()
        .map((snap) => snap.docs.map((d) => PromptModel.fromDoc(d)).toList());
  }

  Stream<List<PromptModel>> getPromptsBySubcategory(
      String categoryId, String subcategoryId) {
    return _db
        .collection('prompts')
        .where('categoryId', isEqualTo: categoryId)
        .where('subcategoryId', isEqualTo: subcategoryId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => PromptModel.fromDoc(d)).toList());
  }

  Future<PromptModel?> getPrompt(String promptId) async {
    final doc = await _db.collection('prompts').doc(promptId).get();
    if (!doc.exists) return null;
    return PromptModel.fromDoc(doc);
  }

  Future<int> getTotalPrompts() async {
    final snap = await _db.collection('prompts').get();
    return snap.docs.length;
  }

  Stream<List<PromptModel>> getPromptsWithExamples({int limit = 20}) {
    return _db
        .collection('prompts')
        .where('hasExample', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snap) => snap.docs.map((d) => PromptModel.fromDoc(d)).toList());
  }

  Stream<List<PromptModel>> getFeaturedPrompts({int limit = 10}) {
    return _db
        .collection('prompts')
        .where('isFeatured', isEqualTo: true)
        .orderBy('usageCount', descending: true)
        .limit(limit)
        .snapshots()
        .map((snap) => snap.docs.map((d) => PromptModel.fromDoc(d)).toList());
  }

  Stream<List<PromptModel>> getPromptsByPlatform(
      String platformKey, {
        int limit = 20,
      }) {
    return _db
        .collection('prompts')
        .where('platformKey', isEqualTo: platformKey)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snap) => snap.docs.map((d) => PromptModel.fromDoc(d)).toList());
  }

  Stream<List<PromptModel>> getMostUsedPrompts({int limit = 10}) {
    return _db
        .collection('prompts')
        .orderBy('usageCount', descending: true)
        .limit(limit)
        .snapshots()
        .map((snap) => snap.docs.map((d) => PromptModel.fromDoc(d)).toList());
  }

  Future<List<PromptModel>> searchPrompts(String query) async {
    final lowerQuery = query.toLowerCase();
    final snap = await _db.collection('prompts').get();
    return snap.docs
        .map((d) => PromptModel.fromDoc(d))
        .where((p) =>
    p.title.toLowerCase().contains(lowerQuery) ||
        p.description.toLowerCase().contains(lowerQuery) ||
        p.text.toLowerCase().contains(lowerQuery) ||
        p.platform.toLowerCase().contains(lowerQuery) ||
        p.tags.any((tag) => tag.toLowerCase().contains(lowerQuery)))
        .toList();
  }

  Future<List<PromptModel>> searchPromptsWithFilters({
    required String query,
    String? categoryId,
    String? platformKey,
    bool? hasExample,
    bool? isFeatured,
  }) async {
    final lowerQuery = query.toLowerCase();
    Query<Map<String, dynamic>> baseQuery = _db.collection('prompts');

    if (categoryId != null) baseQuery = baseQuery.where('categoryId', isEqualTo: categoryId);
    if (platformKey != null) baseQuery = baseQuery.where('platformKey', isEqualTo: platformKey);
    if (hasExample != null) baseQuery = baseQuery.where('hasExample', isEqualTo: hasExample);
    if (isFeatured != null) baseQuery = baseQuery.where('isFeatured', isEqualTo: isFeatured);

    final snap = await baseQuery.get();
    if (query.isEmpty) return snap.docs.map((d) => PromptModel.fromDoc(d)).toList();

    return snap.docs
        .map((d) => PromptModel.fromDoc(d))
        .where((p) =>
    p.title.toLowerCase().contains(lowerQuery) ||
        p.description.toLowerCase().contains(lowerQuery) ||
        p.text.toLowerCase().contains(lowerQuery) ||
        p.tags.any((tag) => tag.toLowerCase().contains(lowerQuery)))
        .toList();
  }

  Future<void> addPrompt(Map<String, dynamic> data) async {
    data['createdAt'] = FieldValue.serverTimestamp();
    await _db.collection('prompts').add(data);
  }

  Future<String> addPromptFromModel(PromptModel prompt) async {
    final docRef = await _db.collection('prompts').add(prompt.toFirestore());
    return docRef.id;
  }

  Future<void> updatePrompt(String id, Map<String, dynamic> data) async {
    await _db.collection('prompts').doc(id).update(data);
  }

  Future<void> updatePromptExample(
      String promptId, {
        required bool hasExample,
        required String exampleType,
        String? exampleImageUrl,
        String? exampleVideoId,
        String? thumbnailUrl,
      }) async {
    await _db.collection('prompts').doc(promptId).update({
      'hasExample': hasExample,
      'exampleType': exampleType,
      'exampleImageUrl': exampleImageUrl,
      'exampleVideoId': exampleVideoId,
      'thumbnailUrl': thumbnailUrl,
    });
  }

  Future<void> incrementPromptUsage(String promptId) async {
    await _db.collection('prompts').doc(promptId).update({
      'usageCount': FieldValue.increment(1),
    });
  }

  Future<void> togglePromptFeatured(String promptId, bool isFeatured) async {
    await _db.collection('prompts').doc(promptId).update({
      'isFeatured': isFeatured,
    });
  }

  Future<void> deletePrompt(String promptId) async {
    await _db.collection('prompts').doc(promptId).delete();
  }

  // TRENDING PROMPTS
  Stream<List<PromptModel>> getTrendingPrompts({int limit = 5}) {
    final today = DateTime.now();
    final daySeed = today.year * 10000 + today.month * 100 + today.day;

    return _db
        .collection('prompts')
        .orderBy('createdAt', descending: true)
        .limit(50)
        .snapshots()
        .map((snap) {
      final prompts = snap.docs.map((d) => PromptModel.fromDoc(d)).toList();
      prompts.shuffle(Random(daySeed));
      return prompts.take(limit).toList();
    });
  }

  Stream<List<PromptModel>> getTrendingPromptsWithExamples({int limit = 5}) {
    final today = DateTime.now();
    final daySeed = today.year * 10000 + today.month * 100 + today.day;

    return _db
        .collection('prompts')
        .where('hasExample', isEqualTo: true)
        .orderBy('usageCount', descending: true)
        .limit(50)
        .snapshots()
        .map((snap) {
      final prompts = snap.docs.map((d) => PromptModel.fromDoc(d)).toList();
      prompts.shuffle(Random(daySeed));
      return prompts.take(limit).toList();
    });
  }

  Future<int> getPromptCountByCategory(String categoryId) async {
    final snap = await _db
        .collection('prompts')
        .where('categoryId', isEqualTo: categoryId)
        .get();
    return snap.docs.length;
  }

  Future<int> getPromptsWithExamplesCount() async {
    final snap = await _db
        .collection('prompts')
        .where('hasExample', isEqualTo: true)
        .get();
    return snap.docs.length;
  }

  Future<int> getFeaturedPromptsCount() async {
    final snap = await _db
        .collection('prompts')
        .where('isFeatured', isEqualTo: true)
        .get();
    return snap.docs.length;
  }

  Future<Map<String, int>> getPlatformStatistics() async {
    final snap = await _db.collection('prompts').get();
    final Map<String, int> stats = {};

    for (final doc in snap.docs) {
      final prompt = PromptModel.fromDoc(doc);
      final platform = prompt.platformKey;
      stats[platform] = (stats[platform] ?? 0) + 1;
    }

    return stats;
  }

  Future<void> updateCategoryPromptCount(String categoryId) async {
    final count = await getPromptCountByCategory(categoryId);
    await _db.collection('categories').doc(categoryId).update({
      'promptCount': count,
    });
  }

  Future<void> updateAllCategoryPromptCounts() async {
    final categories = await _db.collection('categories').get();

    for (final catDoc in categories.docs) {
      final count = await getPromptCountByCategory(catDoc.id);
      await catDoc.reference.update({'promptCount': count});
    }
  }

  Future<void> updateSubcategoryPromptCount(
      String categoryId,
      String subcategoryId,
      ) async {
    final snap = await _db
        .collection('prompts')
        .where('categoryId', isEqualTo: categoryId)
        .where('subcategoryId', isEqualTo: subcategoryId)
        .get();

    await _db
        .collection('categories')
        .doc(categoryId)
        .collection('subcategories')
        .doc(subcategoryId)
        .update({'promptCount': snap.docs.length});
  }

  Future<void> clearAllData() async {
    final prompts = await _db.collection('prompts').get();
    for (final doc in prompts.docs) {
      await doc.reference.delete();
    }

    final categories = await _db.collection('categories').get();
    for (final cat in categories.docs) {
      final subs = await cat.reference.collection('subcategories').get();
      for (final sub in subs.docs) {
        await sub.reference.delete();
      }
      await cat.reference.delete();
    }
  }
}
