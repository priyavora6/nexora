import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../config/app_constants.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
    var hash = sha256.convert(bytes);
    return hash.toString();
  }

  Future<User?> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final User? user = result.user;

      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();

        String hashedPassword = _hashPassword(password);
        bool isAdminEmail = email.trim().toLowerCase() == AppConstants.adminEmail.toLowerCase();

        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': name,
          'email': email.trim(),
          'password': hashedPassword,
          'role': isAdminEmail ? 'admin' : 'user',
          'createdAt': FieldValue.serverTimestamp(),
          'lastLogin': FieldValue.serverTimestamp(),
          'profileComplete': true,
          'isActive': true,
          'accountStatus': 'Active',
        });

        if (isAdminEmail) {
          await _ensureAdminExists(user);
        }
      }

      return _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      throw 'An unexpected error occurred during sign up.';
    }
  }

  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (result.user != null) {
        String hashedPassword = _hashPassword(password);

        await _firestore.collection('users').doc(result.user!.uid).set({
          'lastLogin': FieldValue.serverTimestamp(),
          'password': hashedPassword,
          'email': result.user!.email,
          'uid': result.user!.uid,
        }, SetOptions(merge: true));

        if (email.trim().toLowerCase() == AppConstants.adminEmail.toLowerCase()) {
          await _ensureAdminExists(result.user!);
        }

        final adminDoc = await _firestore.collection('admins').doc(result.user!.uid).get();

        if (adminDoc.exists) {
          final adminData = adminDoc.data() as Map<String, dynamic>;
          bool isActive = adminData['isActive'] ?? true;

          if (!isActive) {
            await _auth.signOut();
            throw 'Your admin account has been suspended. Contact support.';
          }

          await _firestore.collection('admins').doc(result.user!.uid).set({
            'lastLoginAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
        }
      }

      return result.user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      if (e.toString().contains('suspended')) throw e;
      throw 'An unexpected error occurred during sign in.';
    }
  }

  Future<void> _ensureAdminExists(User user) async {
    try {
      final adminRef = _firestore.collection('admins').doc(user.uid);
      final adminDoc = await adminRef.get();

      if (!adminDoc.exists) {
        await adminRef.set({
          'uid': user.uid,
          'email': user.email?.toLowerCase(),
          'role': 'super_admin',
          'displayName': user.displayName ?? 'Admin',
          'createdAt': FieldValue.serverTimestamp(),
          'lastLoginAt': FieldValue.serverTimestamp(),
          'isActive': true,
          'permissions': [
            'manage_categories',
            'manage_prompts',
            'manage_users',
            'manage_admins',
            'view_analytics'
          ],
        });
      } else {
        await adminRef.set({
          'lastLoginAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }
    } catch (e) {
      print('❌ Error ensuring admin exists: $e');
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<void> deleteAccount(String password) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw 'No user is currently signed in.';
      final credential = EmailAuthProvider.credential(email: user.email!, password: password);
      await user.reauthenticateWithCredential(credential);
      await _firestore.collection('users').doc(user.uid).delete();
      await user.delete();
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<void> changePassword({required String currentPassword, required String newPassword}) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw 'No user signed in.';
      final credential = EmailAuthProvider.credential(email: user.email!, password: currentPassword);
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<void> signOut() async => await _auth.signOut();

  Future<bool> isAdmin(String uid) async {
    final doc = await _firestore.collection('admins').doc(uid).get();
    return doc.exists;
  }

  Future<void> sendEmailVerification() async => await _auth.currentUser?.sendEmailVerification();

  Future<bool> isEmailVerified() async {
    await _auth.currentUser?.reload();
    return _auth.currentUser?.emailVerified ?? false;
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.data();
  }

  // ✅ ADDED: Update user data (for interests, etc)
  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(uid).set(data, SetOptions(merge: true));
  }

  Future<void> updateUserProfile({String? displayName, String? photoURL}) async {
    final user = _auth.currentUser;
    if (user == null) return;
    if (displayName != null) await user.updateDisplayName(displayName);
    if (photoURL != null) await user.updatePhotoURL(photoURL);
    final data = <String, dynamic>{'updatedAt': FieldValue.serverTimestamp()};
    if (displayName != null) data['name'] = displayName;
    if (photoURL != null) data['photoURL'] = photoURL;
    await _firestore.collection('users').doc(user.uid).set(data, SetOptions(merge: true));
  }

  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password': return 'Password is too weak.';
      case 'email-already-in-use': return 'Email already registered.';
      case 'user-not-found': return 'No account found with this email.';
      case 'wrong-password': return 'Incorrect password.';
      case 'invalid-credential': return 'Invalid credentials.';
      case 'too-many-requests': return 'Too many attempts. Try later.';
      default: return e.message ?? 'Authentication error.';
    }
  }
}
