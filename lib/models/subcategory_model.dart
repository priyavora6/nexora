import 'package:cloud_firestore/cloud_firestore.dart';

class SubcategoryModel {
  final String id;
  final String name;
  final String icon;
  final int order;
  final int promptCount;
  final DateTime? createdAt;

  SubcategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.order,
    required this.promptCount,
    this.createdAt,
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
    );
  }
}