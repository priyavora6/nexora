// lib/models/user_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String? profileImageUrl;
  final List<String> interests; // Category IDs user selected
  final List<String> savedPrompts; // Saved prompt IDs
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? accountStatus;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.profileImageUrl,
    this.interests = const [],
    this.savedPrompts = const [],
    required this.createdAt,
    this.updatedAt,
    this.accountStatus,
  });

  // Check if user has completed onboarding (selected interests)
  bool get hasCompletedOnboarding => interests.isNotEmpty;

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      profileImageUrl: map['profileImageUrl'],
      interests: List<String>.from(map['interests'] ?? []),
      savedPrompts: List<String>.from(map['savedPrompts'] ?? []),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate(),
      accountStatus: map['accountStatus'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'profileImageUrl': profileImageUrl,
      'interests': interests,
      'savedPrompts': savedPrompts,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'accountStatus': accountStatus,
    };
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? profileImageUrl,
    List<String>? interests,
    List<String>? savedPrompts,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? accountStatus,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      interests: interests ?? this.interests,
      savedPrompts: savedPrompts ?? this.savedPrompts,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      accountStatus: accountStatus ?? this.accountStatus,
    );
  }
}
