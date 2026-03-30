import 'package:cloud_firestore/cloud_firestore.dart';

class SubcategoryModel {
  final String id;
  final String name;
  final String icon;
  final int order;
  final int promptCount;
  final DateTime? createdAt;

  // ➕ NEW FIELDS
  final String categoryId; // Parent category reference
  final String categoryName; // For easier queries
  final String description;
  final String? featuredExampleUrl; // 1 standout example
  final String? featuredExampleType; // "image" or "video"

  SubcategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.order,
    this.promptCount = 0,
    this.createdAt,

    // ➕ NEW FIELDS WITH DEFAULTS
    this.categoryId = '',
    this.categoryName = '',
    this.description = '',
    this.featuredExampleUrl,
    this.featuredExampleType,
  });

  factory SubcategoryModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SubcategoryModel(
      id: doc.id,
      name: data['name'] ?? '',
      icon: data['icon'] ?? '📁',
      order: data['order'] ?? 0,
      promptCount: data['promptCount'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),

      // ➕ PARSE NEW FIELDS
      categoryId: data['categoryId'] ?? '',
      categoryName: data['categoryName'] ?? '',
      description: data['description'] ?? '',
      featuredExampleUrl: data['featuredExampleUrl'],
      featuredExampleType: data['featuredExampleType'],
    );
  }

  // ➕ TO FIRESTORE MAP
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'icon': icon,
      'order': order,
      'promptCount': promptCount,
      'createdAt': FieldValue.serverTimestamp(),
      'categoryId': categoryId,
      'categoryName': categoryName,
      'description': description,
      'featuredExampleUrl': featuredExampleUrl,
      'featuredExampleType': featuredExampleType,
    };
  }

  // ➕ COPY WITH METHOD
  SubcategoryModel copyWith({
    String? id,
    String? name,
    String? icon,
    int? order,
    int? promptCount,
    String? categoryId,
    String? categoryName,
    String? description,
    String? featuredExampleUrl,
    String? featuredExampleType,
  }) {
    return SubcategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      order: order ?? this.order,
      promptCount: promptCount ?? this.promptCount,
      createdAt: createdAt,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      description: description ?? this.description,
      featuredExampleUrl: featuredExampleUrl ?? this.featuredExampleUrl,
      featuredExampleType: featuredExampleType ?? this.featuredExampleType,
    );
  }

  // ➕ HELPER METHODS

  /// Check if subcategory has featured example
  bool get hasFeaturedExample =>
      featuredExampleUrl != null && featuredExampleUrl!.isNotEmpty;

  /// Check if featured example is an image
  bool get hasFeaturedImage =>
      hasFeaturedExample && featuredExampleType == 'image';

  /// Check if featured example is a video
  bool get hasFeaturedVideo =>
      hasFeaturedExample && featuredExampleType == 'video';
}
