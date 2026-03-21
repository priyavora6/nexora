import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;
  bool _isLoading = false;
  bool _isAdmin = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAdmin => _isAdmin;
  bool get isLoggedIn => _user != null;
  String? get error => _error;
  String get userName => _user?.displayName ?? 'User';
  String get userEmail => _user?.email ?? '';

  AuthProvider() {
    _user = _authService.currentUser;
    if (_user != null) _checkAdmin();
  }

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    try {
      _user = await _authService.signUp(
        email: email,
        password: password,
        name: name,
      );
      _error = null;
      _setLoading(false);
      return true;
    } catch (e) {
      _error = e.toString();
      _setLoading(false);
      return false;
    }
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    try {
      _user = await _authService.signIn(
        email: email,
        password: password,
      );
      await _checkAdmin();
      _error = null;
      _setLoading(false);
      return true;
    } catch (e) {
      _error = e.toString();
      _setLoading(false);
      return false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    _isAdmin = false;
    _error = null;
    notifyListeners();
  }

  Future<void> _checkAdmin() async {
    if (_user != null) {
      _isAdmin = await _authService.isAdmin(_user!.uid);
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }
}