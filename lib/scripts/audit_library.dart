import '../data/prompt_library.dart';
import '../services/seed/category_data.dart';
import '../services/seed/subcategory_data.dart';

void main() {
  final categories = CategoryData.getAllCategories();
  int totalExpected = 0;
  int totalFound = 0;

  print('📊 NEXORA LIBRARY AUDIT\n');

  for (final cat in categories) {
    final catName = cat['name']!;
    final subs = SubcategoryData.getSubcategories(catName);
    int catCount = 0;

    print('📁 $catName:');
    for (final sub in subs) {
      final subName = sub['name']!;
      final prompts = PromptLibrary.getAllPrompts()
          .where((p) => p['category'] == catName && p['subcategory'] == subName)
          .toList();
      
      print('   - $subName: ${prompts.length} prompts');
      catCount += prompts.length;
      totalFound += prompts.length;
      totalExpected += 10;
    }
    print('   ✨ Total for $catName: $catCount/60\n');
  }

  print('══════════════════════════════════════════════════');
  print('📈 FINAL STATS');
  print('   Found:    $totalFound');
  print('   Expected: $totalExpected');
  print('   Missing:  ${totalExpected - totalFound}');
  print('══════════════════════════════════════════════════');
}
