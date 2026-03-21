import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_constants.dart';

class LocalStorageService {
  // ═══════════════════════════════
  // ♡ FAVORITES
  // ═══════════════════════════════

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(AppConstants.keyFavorites) ?? [];
  }

  static Future<void> addFavorite(String promptId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(AppConstants.keyFavorites) ?? [];
    if (!favorites.contains(promptId)) {
      favorites.add(promptId);
      await prefs.setStringList(AppConstants.keyFavorites, favorites);
    }
  }

  static Future<void> removeFavorite(String promptId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(AppConstants.keyFavorites) ?? [];
    favorites.remove(promptId);
    await prefs.setStringList(AppConstants.keyFavorites, favorites);
  }

  static Future<bool> isFavorite(String promptId) async {
    final favorites = await getFavorites();
    return favorites.contains(promptId);
  }

  static Future<void> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.keyFavorites);
  }

  // ═══════════════════════════════
  // 🔍 RECENT SEARCHES
  // ═══════════════════════════════

  static Future<List<String>> getRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(AppConstants.keyRecentSearch) ?? [];
  }

  static Future<void> addRecentSearch(String query) async {
    final prefs = await SharedPreferences.getInstance();
    final searches = prefs.getStringList(AppConstants.keyRecentSearch) ?? [];
    searches.remove(query); // Remove if exists
    searches.insert(0, query); // Add to top
    if (searches.length > 10) searches.removeLast(); // Max 10
    await prefs.setStringList(AppConstants.keyRecentSearch, searches);
  }

  static Future<void> clearRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.keyRecentSearch);
  }

  // ═══════════════════════════════
  // 🎨 ONBOARDING
  // ═══════════════════════════════

  static Future<bool> isOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.keyOnboardingSeen) ?? false;
  }

  static Future<void> setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyOnboardingSeen, true);
  }
}