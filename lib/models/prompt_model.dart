import 'package:cloud_firestore/cloud_firestore.dart';

class PromptModel {
  final String id;
  final String title;
  final String text;
  final String categoryId;
  final String categoryName;
  final String subcategoryId;
  final String subcategoryName;
  final String platform;
  final String description;
  final DateTime? createdAt;

  PromptModel({
    required this.id,
    required this.title,
    required this.text,
    required this.categoryId,
    this.categoryName = '',
    this.subcategoryId = '',
    this.subcategoryName = '',
    required this.platform,
    this.description = '',
    this.createdAt,
  });

  factory PromptModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PromptModel(
      id: doc.id,
      title: data['title'] ?? '',
      text: data['text'] ?? '',
      categoryId: data['categoryId'] ?? '',
      categoryName: data['categoryName'] ?? '',
      subcategoryId: data['subcategoryId'] ?? '',
      subcategoryName: data['subcategoryName'] ?? '',
      platform: data['platform'] ?? 'Other',
      description: data['description'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'text': text,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'subcategoryId': subcategoryId,
      'subcategoryName': subcategoryName,
      'platform': platform,
      'description': description,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  PromptModel copyWith({
    String? id,
    String? title,
    String? text,
    String? categoryId,
    String? categoryName,
    String? subcategoryId,
    String? subcategoryName,
    String? platform,
    String? description,
  }) {
    return PromptModel(
      id: id ?? this.id,
      title: title ?? this.title,
      text: text ?? this.text,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      subcategoryId: subcategoryId ?? this.subcategoryId,
      subcategoryName: subcategoryName ?? this.subcategoryName,
      platform: platform ?? this.platform,
      description: description ?? this.description,
      createdAt: createdAt,
    );
  }
}
