import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  final String uid;
  final String email;
  final String role;

  // ➕ NEW FIELDS
  final String displayName;
  final DateTime? createdAt;
  final DateTime? lastLoginAt;
  final bool isActive;
  final List<String> permissions; // Future: granular permissions

  AdminModel({
    required this.uid,
    required this.email,
    this.role = 'admin',

    // ➕ NEW FIELDS WITH DEFAULTS
    this.displayName = '',
    this.createdAt,
    this.lastLoginAt,
    this.isActive = true,
    this.permissions = const [],
  });

  // ➕ FROM FIRESTORE DOCUMENT
  factory AdminModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AdminModel(
      uid: doc.id,
      email: data['email'] ?? '',
      role: data['role'] ?? 'admin',
      displayName: data['displayName'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      lastLoginAt: (data['lastLoginAt'] as Timestamp?)?.toDate(),
      isActive: data['isActive'] ?? true,
      permissions: List<String>.from(data['permissions'] ?? []),
    );
  }

  // FROM MAP (keep for backward compatibility)
  factory AdminModel.fromMap(String uid, Map<String, dynamic> data) {
    return AdminModel(
      uid: uid,
      email: data['email'] ?? '',
      role: data['role'] ?? 'admin',
      displayName: data['displayName'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      lastLoginAt: (data['lastLoginAt'] as Timestamp?)?.toDate(),
      isActive: data['isActive'] ?? true,
      permissions: List<String>.from(data['permissions'] ?? []),
    );
  }

  // TO FIRESTORE MAP
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'role': role,
      'displayName': displayName,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
      'lastLoginAt': lastLoginAt != null
          ? Timestamp.fromDate(lastLoginAt!)
          : null,
      'isActive': isActive,
      'permissions': permissions,
    };
  }

  // ➕ TO FIRESTORE (alternative method name)
  Map<String, dynamic> toFirestore() => toMap();

  // ➕ COPY WITH METHOD
  AdminModel copyWith({
    String? uid,
    String? email,
    String? role,
    String? displayName,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    bool? isActive,
    List<String>? permissions,
  }) {
    return AdminModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      role: role ?? this.role,
      displayName: displayName ?? this.displayName,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      isActive: isActive ?? this.isActive,
      permissions: permissions ?? this.permissions,
    );
  }

  // ➕ UPDATE LAST LOGIN
  AdminModel updateLastLogin() {
    return copyWith(lastLoginAt: DateTime.now());
  }

  // ➕ HELPER METHODS

  /// Check if admin is super admin
  bool get isSuperAdmin => role == 'super_admin';

  /// Check if admin can manage categories
  bool get canManageCategories =>
      permissions.contains('manage_categories') || isSuperAdmin;

  /// Check if admin can manage prompts
  bool get canManagePrompts =>
      permissions.contains('manage_prompts') || isSuperAdmin;

  /// Check if admin can manage users
  bool get canManageUsers =>
      permissions.contains('manage_users') || isSuperAdmin;

  /// Check if admin can upload examples
  bool get canUploadExamples =>
      permissions.contains('upload_examples') || isSuperAdmin;

  /// Get display name or fallback to email
  String get displayNameOrEmail =>
      displayName.isNotEmpty ? displayName : email.split('@').first;
}