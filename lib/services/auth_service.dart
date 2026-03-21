import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../config/app_constants.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // ═══════════════════════════════════════════════════════════
  // SIGN UP - Store user profile in Firestore (NO password)
  // ═══════════════════════════════════════════════════════════
  Future<User?> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = result.user;

      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();

        // ✅ Store user profile in Firestore (NO password stored)
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': name,
          'email': email,
          'role': 'user',
          'createdAt': FieldValue.serverTimestamp(),
          'lastLogin': FieldValue.serverTimestamp(),
          'profileComplete': true,
          'favorites': [],
        });
      }

      return _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      throw 'An unexpected error occurred during sign up.';
    }
  }

  // ═══════════════════════════════════════════════════════════
  // SIGN IN - Update last login time
  // ═══════════════════════════════════════════════════════════
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // ✅ Update last login timestamp
      if (result.user != null) {
        await _firestore.collection('users').doc(result.user!.uid).update({
          'lastLogin': FieldValue.serverTimestamp(),
        });
      }

      if (email == AppConstants.adminEmail) {
        await _ensureAdminExists(result.user!);
      }

      return result.user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  // ═══════════════════════════════════════════════════════════
  // ENSURE ADMIN EXISTS
  // ═══════════════════════════════════════════════════════════
  Future<void> _ensureAdminExists(User user) async {
    try {
      final adminDoc = await _firestore.collection('admins').doc(user.uid).get();
      if (!adminDoc.exists) {
        await _firestore.collection('admins').doc(user.uid).set({
          'email': AppConstants.adminEmail,
          'role': 'admin',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error ensuring admin exists: $e');
    }
  }

  // ═══════════════════════════════════════════════════════════
  // SIGN OUT
  // ═══════════════════════════════════════════════════════════
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // ═══════════════════════════════════════════════════════════
  // CHECK IF USER IS ADMIN
  // ═══════════════════════════════════════════════════════════
  Future<bool> isAdmin(String uid) async {
    try {
      final doc = await _firestore.collection('admins').doc(uid).get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  // ═══════════════════════════════════════════════════════════
  // ERROR HANDLER
  // ═══════════════════════════════════════════════════════════
  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'invalid-credential':
        return 'Invalid login credentials provided.';
      case 'network-request-failed':
        return 'Please check your internet connection.';
      default:
        return e.message ?? 'Authentication failed. Please try again.';
    }
  }
}