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

  /// Get all categories stream
  Stream<List<CategoryModel>> getCategories() {
    return _db
        .collection('categories')
        .orderBy('order')
        .snapshots()
        .map((snap) => snap.docs.map((d) => CategoryModel.fromDoc(d)).toList());
  }

  /// Get total categories count
  Future<int> getTotalCategories() async {
    final snap = await _db.collection('categories').get();
    return snap.docs.length;
  }

  /// Add category and return ID
  Future<String> addCategoryAndGetId(Map<String, dynamic> data) async {
    data['createdAt'] = FieldValue.serverTimestamp();
    final ref = await _db.collection('categories').add(data);
    return ref.id;
  }

  /// Add category from model
  Future<void> addCategory(CategoryModel cat) async {
    await _db.collection('categories').add({
      'name': cat.name,
      'icon': cat.icon,
      'color': cat.color,
      'order': 0,
      'promptCount': 0,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Update category
  Future<void> updateCategory(String id, Map<String, dynamic> data) async {
    await _db.collection('categories').doc(id).update(data);
  }

  /// Delete category and all its data
  Future<void> deleteCategory(String categoryId) async {
    // Delete all prompts in this category
    final prompts = await _db
        .collection('prompts')
        .where('categoryId', isEqualTo: categoryId)
        .get();
    for (final doc in prompts.docs) {
      await doc.reference.delete();
    }

    // Delete all subcategories
    final subs = await _db
        .collection('categories')
        .doc(categoryId)
        .collection('subcategories')
        .get();
    for (final doc in subs.docs) {
      await doc.reference.delete();
    }

    // Delete the category
    await _db.collection('categories').doc(categoryId).delete();
  }

  // ══════════════════════════════════════════════
  // 📂 SUBCATEGORIES
  // ══════════════════════════════════════════════

  /// Get subcategories stream
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

  /// Get subcategories as list (not stream)
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

  /// Add subcategory
  Future<void> addSubcategory(
      String categoryId, Map<String, dynamic> data) async {
    data['createdAt'] = FieldValue.serverTimestamp();
    await _db
        .collection('categories')
        .doc(categoryId)
        .collection('subcategories')
        .add(data);
  }

  /// Delete all subcategories
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

  /// Get all prompts stream
  Stream<List<PromptModel>> getPrompts() {
    return _db
        .collection('prompts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => PromptModel.fromDoc(d)).toList());
  }

  /// Get recent prompts (limited)
  Stream<List<PromptModel>> getRecentPrompts({int limit = 10}) {
    return _db
        .collection('prompts')
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snap) => snap.docs.map((d) => PromptModel.fromDoc(d)).toList());
  }

  /// Get prompts by category
  Stream<List<PromptModel>> getPromptsByCategory(String categoryId) {
    return _db
        .collection('prompts')
        .where('categoryId', isEqualTo: categoryId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => PromptModel.fromDoc(d)).toList());
  }

  /// Get prompts by subcategory
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

  /// Get single prompt
  Future<PromptModel?> getPrompt(String promptId) async {
    final doc = await _db.collection('prompts').doc(promptId).get();
    if (!doc.exists) return null;
    return PromptModel.fromDoc(doc);
  }

  /// Get total prompts count
  Future<int> getTotalPrompts() async {
    final snap = await _db.collection('prompts').get();
    return snap.docs.length;
  }

  /// Search prompts
  Future<List<PromptModel>> searchPrompts(String query) async {
    final lowerQuery = query.toLowerCase();

    final snap = await _db.collection('prompts').get();

    return snap.docs
        .map((d) => PromptModel.fromDoc(d))
        .where((p) =>
    p.title.toLowerCase().contains(lowerQuery) ||
        p.description.toLowerCase().contains(lowerQuery) ||
        p.text.toLowerCase().contains(lowerQuery) ||
        p.platform.toLowerCase().contains(lowerQuery))
        .toList();
  }

  /// Add prompt
  Future<void> addPrompt(Map<String, dynamic> data) async {
    data['createdAt'] = FieldValue.serverTimestamp();
    await _db.collection('prompts').add(data);
  }

  /// Update prompt
  Future<void> updatePrompt(String id, Map<String, dynamic> data) async {
    await _db.collection('prompts').doc(id).update(data);
  }

  /// Delete prompt
  Future<void> deletePrompt(String promptId) async {
    await _db.collection('prompts').doc(promptId).delete();
  }

  // ══════════════════════════════════════════════
  // 🔥 TRENDING PROMPTS (Changes Daily)
  // ══════════════════════════════════════════════

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

  // ══════════════════════════════════════════════
  // 🗑️ CLEAR ALL DATA
  // ══════════════════════════════════════════════

  Future<void> clearAllData() async {
    // Delete all prompts
    final prompts = await _db.collection('prompts').get();
    for (final doc in prompts.docs) {
      await doc.reference.delete();
    }

    // Delete all categories and subcategories
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
