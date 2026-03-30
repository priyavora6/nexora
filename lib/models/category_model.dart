import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String name;
  final String icon;
  final String color;
  final int promptCount;
  final DateTime? createdAt;

  // ➕ NEW FIELDS FOR HERO EXAMPLES
  final String description;
  final List<String> heroExampleUrls; // 5 showcase images/videos
  final List<String> heroExampleTypes; // "image" or "video" for each
  final int subcategoryCount;
  final int order; // For sorting categories

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    this.promptCount = 0,
    this.createdAt,

    // ➕ NEW FIELDS WITH DEFAULTS
    this.description = '',
    this.heroExampleUrls = const [],
    this.heroExampleTypes = const [],
    this.subcategoryCount = 0,
    this.order = 0,
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

      // ➕ PARSE NEW FIELDS
      description: data['description'] ?? '',
      heroExampleUrls: List<String>.from(data['heroExampleUrls'] ?? []),
      heroExampleTypes: List<String>.from(data['heroExampleTypes'] ?? []),
      subcategoryCount: data['subcategoryCount'] ?? 0,
      order: data['order'] ?? 0,
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

      // ➕ INCLUDE NEW FIELDS
      'description': description,
      'heroExampleUrls': heroExampleUrls,
      'heroExampleTypes': heroExampleTypes,
      'subcategoryCount': subcategoryCount,
      'order': order,
    };
  }

  // Copy with
  CategoryModel copyWith({
    String? id,
    String? name,
    String? icon,
    String? color,
    int? promptCount,
    // ➕ NEW PARAMETERS
    String? description,
    List<String>? heroExampleUrls,
    List<String>? heroExampleTypes,
    int? subcategoryCount,
    int? order,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      promptCount: promptCount ?? this.promptCount,
      createdAt: createdAt,

      // ➕ COPY NEW FIELDS
      description: description ?? this.description,
      heroExampleUrls: heroExampleUrls ?? this.heroExampleUrls,
      heroExampleTypes: heroExampleTypes ?? this.heroExampleTypes,
      subcategoryCount: subcategoryCount ?? this.subcategoryCount,
      order: order ?? this.order,
    );
  }

  // ➕ HELPER METHODS

  /// Check if category has hero examples
  bool get hasHeroExamples => heroExampleUrls.isNotEmpty;

  /// Get count of hero examples
  int get heroExampleCount => heroExampleUrls.length;

  /// Check if hero examples are valid (URLs and types match)
  bool get heroExamplesValid =>
      heroExampleUrls.length == heroExampleTypes.length;

  /// Get only image hero examples
  List<String> get imageHeroExamples {
    List<String> images = [];
    for (int i = 0; i < heroExampleUrls.length; i++) {
      if (i < heroExampleTypes.length && heroExampleTypes[i] == 'image') {
        images.add(heroExampleUrls[i]);
      }
    }
    return images;
  }

  /// Get only video hero examples
  List<String> get videoHeroExamples {
    List<String> videos = [];
    for (int i = 0; i < heroExampleUrls.length; i++) {
      if (i < heroExampleTypes.length && heroExampleTypes[i] == 'video') {
        videos.add(heroExampleUrls[i]);
      }
    }
    return videos;
  }

  /// Get hero example with its type at specific index
  Map<String, String>? getHeroExampleAt(int index) {
    if (index >= heroExampleUrls.length) return null;

    return {
      'url': heroExampleUrls[index],
      'type': index < heroExampleTypes.length
          ? heroExampleTypes[index]
          : 'image', // default to image if type missing
    };
  }

  /// Get all hero examples as list of maps
  List<Map<String, String>> get heroExamplesList {
    List<Map<String, String>> examples = [];
    for (int i = 0; i < heroExampleUrls.length; i++) {
      examples.add({
        'url': heroExampleUrls[i],
        'type': i < heroExampleTypes.length
            ? heroExampleTypes[i]
            : 'image',
      });
    }
    return examples;
  }

  /// Get first hero example (for preview)
  String? get firstHeroExample =>
      heroExampleUrls.isNotEmpty ? heroExampleUrls.first : null;
}