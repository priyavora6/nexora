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

  final bool hasExample;
  final String exampleType; 
  final String? exampleImageUrl;
  final String? exampleVideoUrl; 
  final String? thumbnailUrl;
  final String platformKey; 
  final String platformUrl; 
  final bool isFeatured;
  final List<String> tags;
  final int usageCount;

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
    this.hasExample = false,
    this.exampleType = 'none',
    this.exampleImageUrl,
    this.exampleVideoUrl,
    this.thumbnailUrl,
    this.platformKey = '',
    this.platformUrl = '',
    this.isFeatured = false,
    this.tags = const [],
    this.usageCount = 0,
  });

  factory PromptModel.fromMap(Map<String, dynamic> data, String id) {
    return PromptModel(
      id: id,
      title: data['title'] ?? '',
      text: data['text'] ?? '',
      categoryId: data['categoryId'] ?? '',
      categoryName: data['categoryName'] ?? '',
      subcategoryId: data['subcategoryId'] ?? '',
      subcategoryName: data['subcategoryName'] ?? '',
      platform: data['platform'] ?? 'Other',
      description: data['description'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      hasExample: data['hasExample'] ?? false,
      exampleType: data['exampleType'] ?? 'none',
      exampleImageUrl: data['exampleImageUrl'],
      exampleVideoUrl: data['exampleVideoUrl'],
      thumbnailUrl: data['thumbnailUrl'],
      platformKey: data['platformKey'] ?? '',
      platformUrl: data['platformUrl'] ?? '',
      isFeatured: data['isFeatured'] ?? false,
      tags: List<String>.from(data['tags'] ?? []),
      usageCount: data['usageCount'] ?? 0,
    );
  }

  factory PromptModel.fromDoc(DocumentSnapshot doc) {
    return PromptModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
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
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
      'hasExample': hasExample,
      'exampleType': exampleType,
      'exampleImageUrl': exampleImageUrl,
      'exampleVideoUrl': exampleVideoUrl,
      'thumbnailUrl': thumbnailUrl,
      'platformKey': platformKey,
      'platformUrl': platformUrl,
      'isFeatured': isFeatured,
      'tags': tags,
      'usageCount': usageCount,
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
    bool? hasExample,
    String? exampleType,
    String? exampleImageUrl,
    String? exampleVideoUrl,
    String? thumbnailUrl,
    String? platformKey,
    String? platformUrl,
    bool? isFeatured,
    List<String>? tags,
    int? usageCount,
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
      hasExample: hasExample ?? this.hasExample,
      exampleType: exampleType ?? this.exampleType,
      exampleImageUrl: exampleImageUrl ?? this.exampleImageUrl,
      exampleVideoUrl: exampleVideoUrl ?? this.exampleVideoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      platformKey: platformKey ?? this.platformKey,
      platformUrl: platformUrl ?? this.platformUrl,
      isFeatured: isFeatured ?? this.isFeatured,
      tags: tags ?? this.tags,
      usageCount: usageCount ?? this.usageCount,
    );
  }

  bool get hasImageExample => hasExample && exampleType == 'image' && exampleImageUrl != null;
  bool get hasVideoExample => hasExample && exampleType == 'video' && exampleVideoUrl != null;
  String? get displayThumbnail => thumbnailUrl ?? exampleImageUrl;
}
