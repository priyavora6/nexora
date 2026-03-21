import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String name;
  final String icon;
  final String color;
  final int promptCount;
  final DateTime? createdAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    this.promptCount = 0,
    this.createdAt,
  });

  // From Firestore document
  factory CategoryModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CategoryModel(
      id: doc.id,
      name: data['name'] ?? '',
      icon: data['icon'] ?? '📁',
      color: data['color'] ?? '#00B3B3',
      promptCount: data['promptCount'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  // To Firestore map
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'icon': icon,
      'color': color,
      'promptCount': promptCount,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  // Copy with
  CategoryModel copyWith({
    String? id,
    String? name,
    String? icon,
    String? color,
    int? promptCount,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      promptCount: promptCount ?? this.promptCount,
      createdAt: createdAt,
    );
  }
}
