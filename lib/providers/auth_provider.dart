// lib/providers/auth_provider.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../config/app_constants.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _auth.currentUser != null;
  String get userName => _user?.name ?? _auth.currentUser?.displayName ?? 'User';
  String get userEmail => _user?.email ?? _auth.currentUser?.email ?? '';
  List<String> get userInterests => _user?.interests ?? [];
  bool get hasCompletedOnboarding => _user?.hasCompletedOnboarding ?? false;
  
  // 🔒 THE GOLDEN RULE FOR ADMIN ACCESS
  bool get isAdmin {
    final email = _auth.currentUser?.email?.trim().toLowerCase();
    if (email == null) return false;
    
    // Check against the official admin email from .env
    final officialAdmin = AppConstants.adminEmail.trim().toLowerCase();
    
    return email == officialAdmin || 
           _user?.accountStatus == 'admin';
  }

  AuthProvider() {
    _init();
  }

  Future<void> _init() async {
    _auth.authStateChanges().listen((User? firebaseUser) async {
      if (firebaseUser != null) {
        await _fetchUserData(firebaseUser.uid);
      } else {
        _user = null;
        notifyListeners();
      }
    });
  }

  Future<void> _fetchUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        _user = UserModel.fromMap(doc.data()!);
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<bool> updateUserProfile({required String name}) async {
    if (_auth.currentUser == null) return false;
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'name': name,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      await _auth.currentUser?.updateDisplayName(name);
      
      _user = _user?.copyWith(name: name, updatedAt: DateTime.now());
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateUserInterests(List<String> interestIds) async {
    if (_auth.currentUser == null) return false;
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
        'interests': interestIds,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      _user = _user?.copyWith(interests: interestIds, updatedAt: DateTime.now());
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // ✅ ADDED signUp ALIAS FOR BACKWARD COMPATIBILITY
  Future<bool> signUp({required String email, required String password, required String name}) => 
      register(email: email, password: password, name: name);

  Future<bool> register({required String email, required String password, required String name}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await cred.user?.updateDisplayName(name);

      final normalizedEmail = email.trim().toLowerCase();
      final officialAdmin = AppConstants.adminEmail.trim().toLowerCase();
      
      final isNowAdmin = normalizedEmail == officialAdmin;

      final newUser = newUserModel(
        uid: cred.user!.uid,
        email: email,
        name: name,
        interests: [],
        savedPrompts: [],
        createdAt: DateTime.now(),
        accountStatus: isNowAdmin ? 'admin' : 'user',
      );
      await _firestore.collection('users').doc(cred.user!.uid).set(newUser.toMap());
      _user = newUser;
      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _error = _getAuthErrorMessage(e.code);
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      await _fetchUserData(cred.user!.uid);
      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _error = _getAuthErrorMessage(e.code);
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signIn({required String email, required String password}) => login(email: email, password: password);

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await _auth.sendPasswordResetEmail(email: email);
      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _error = _getAuthErrorMessage(e.code);
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // ✅ ADDED: Change Password method
  Future<bool> changePassword({required String currentPassword, required String newPassword}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final user = _auth.currentUser;
      if (user == null) throw 'No user signed in.';
      
      // Re-authenticate user before changing password
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!, 
        password: currentPassword
      );
      
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      
      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _error = _getAuthErrorMessage(e.code);
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'user-not-found': return 'No user found with this email.';
      case 'wrong-password': return 'Incorrect password.';
      case 'email-already-in-use': return 'Email is already registered.';
      case 'weak-password': return 'Password is too weak.';
      case 'invalid-email': return 'Invalid email address.';
      case 'requires-recent-login': return 'Session expired. Please log in again.';
      default: return 'Authentication failed. Please try again.';
    }
  }
}

UserModel newUserModel({
    required String uid,
    required String email,
    required String name,
    List<String> interests = const [],
    List<String> savedPrompts = const [],
    required DateTime createdAt,
    DateTime? updatedAt,
    String? accountStatus,
  }) {
    return UserModel(
      uid: uid,
      email: email,
      name: name,
      interests: interests,
      savedPrompts: savedPrompts,
      createdAt: createdAt,
      updatedAt: updatedAt,
      accountStatus: accountStatus,
    );
}
