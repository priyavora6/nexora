import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/admin_model.dart'; // Ensure this import points to your AdminModel file

class AdminProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  AdminModel? _currentAdmin;
  bool _isLoading = false;

  // ════════════════════════════════════════════════
  // 🔍 GETTERS
  // ════════════════════════════════════════════════

  AdminModel? get admin => _currentAdmin;
  bool get isLoading => _isLoading;

  /// Check if the user is currently logged in as an admin
  bool get isAdmin => _currentAdmin != null;

  // 🔒 Permission Helpers (Shortcuts for UI)
  bool get isSuperAdmin => _currentAdmin?.isSuperAdmin ?? false;
  bool get canManageCategories => _currentAdmin?.canManageCategories ?? false;
  bool get canManagePrompts => _currentAdmin?.canManagePrompts ?? false;
  bool get canManageUsers => _currentAdmin?.canManageUsers ?? false;

  String get displayName => _currentAdmin?.displayNameOrEmail ?? 'Admin';

  // ════════════════════════════════════════════════
  // ⚙️ INITIALIZATION
  // ════════════════════════════════════════════════

  /// Call this in main.dart or Splash Screen to check if user is Admin
  Future<void> checkAdminStatus() async {
    _setLoading(true);

    try {
      final user = _auth.currentUser;

      if (user != null) {
        // Fetch Admin Document
        final doc = await _db.collection('admins').doc(user.uid).get();

        if (doc.exists) {
          final adminData = AdminModel.fromDoc(doc);

          // Check if account is active
          if (adminData.isActive) {
            _currentAdmin = adminData;
            print("✅ AdminProvider: Admin loaded (${adminData.email})");
          } else {
            // Admin is suspended
            print("⛔ AdminProvider: Account suspended");
            await _auth.signOut();
            _currentAdmin = null;
          }
        } else {
          // User is logged in, but is NOT an admin
          _currentAdmin = null;
        }
      } else {
        _currentAdmin = null;
      }
    } catch (e) {
      print("❌ AdminProvider Error: $e");
      _currentAdmin = null;
    } finally {
      _setLoading(false);
    }
  }

  // ════════════════════════════════════════════════
  // 🔄 STATE ACTIONS
  // ════════════════════════════════════════════════

  /// Call this immediately after successful Login
  void setAdmin(AdminModel admin) {
    _currentAdmin = admin;
    notifyListeners();
  }

  /// Refresh admin data from Firestore (useful after updating profile)
  Future<void> refreshAdminData() async {
    if (_currentAdmin == null) return;

    try {
      final doc = await _db.collection('admins').doc(_currentAdmin!.uid).get();
      if (doc.exists) {
        _currentAdmin = AdminModel.fromDoc(doc);
        notifyListeners();
      }
    } catch (e) {
      print("Error refreshing admin data: $e");
    }
  }

  /// Call this on Logout
  void clearAdmin() {
    _currentAdmin = null;
    notifyListeners();
  }

  // ════════════════════════════════════════════════
  // 🛠️ INTERNAL HELPERS
  // ════════════════════════════════════════════════

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}