import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/app_colors.dart';
import '../../models/category_model.dart';
import '../../models/subcategory_model.dart';
import '../../services/firestore_service.dart';
import '../../utils/helpers.dart';
import '../../utils/validators.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_textfield.dart';
import '../../widgets/layout/gradient_app_bar.dart';

class AddEditCategoryScreen extends StatefulWidget {
  final CategoryModel? category;
  const AddEditCategoryScreen({Key? key, this.category}) : super(key: key);

  @override
  State<AddEditCategoryScreen> createState() => _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _iconCtrl = TextEditingController();
  final _colorCtrl = TextEditingController();
  bool _saving = false;
  bool get _isEdit => widget.category != null;

  final List<Map<String, TextEditingController>> _subControllers = [];

  @override
  void initState() {
    super.initState();
    if (_isEdit) {
      _nameCtrl.text = widget.category!.name;
      _iconCtrl.text = widget.category!.icon;
      _colorCtrl.text = widget.category!.color;
      _loadSubcategories();
    } else {
      _iconCtrl.text = '📁';
      _colorCtrl.text = '#3949AB'; // Default changed to Royal Blue
    }
  }

  Future<void> _loadSubcategories() async {
    if (!_isEdit) return;
    final fs = FirestoreService();
    final subs = await fs.getSubcategoriesList(widget.category!.id);
    for (final sub in subs) {
      setState(() {
        _subControllers.add({
          'name': TextEditingController(text: sub.name),
          'icon': TextEditingController(text: sub.icon),
        });
      });
    }
  }

  void _addSubcategoryField() {
    setState(() {
      _subControllers.add({
        'name': TextEditingController(),
        'icon': TextEditingController(text: '📌'),
      });
    });
  }

  void _removeSubcategoryField(int index) {
    setState(() {
      _subControllers[index]['name']!.dispose();
      _subControllers[index]['icon']!.dispose();
      _subControllers.removeAt(index);
    });
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _iconCtrl.dispose();
    _colorCtrl.dispose();
    for (final ctrl in _subControllers) {
      ctrl['name']!.dispose();
      ctrl['icon']!.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    try {
      final fs = FirestoreService();

      if (_isEdit) {
        await fs.updateCategory(widget.category!.id, {
          'name': _nameCtrl.text.trim(),
          'icon': _iconCtrl.text.trim(),
          'color': _colorCtrl.text.trim(),
        });

        await fs.deleteAllSubcategories(widget.category!.id);
        for (int i = 0; i < _subControllers.length; i++) {
          final name = _subControllers[i]['name']!.text.trim();
          final icon = _subControllers[i]['icon']!.text.trim();
          if (name.isNotEmpty) {
            await fs.addSubcategory(widget.category!.id, {
              'name': name,
              'icon': icon.isEmpty ? '📌' : icon,
              'order': i,
              'promptCount': 0,
            });
          }
        }
      } else {
        final catId = await fs.addCategoryAndGetId({
          'name': _nameCtrl.text.trim(),
          'icon': _iconCtrl.text.trim(),
          'color': _colorCtrl.text.trim(),
          'order': 0,
          'promptCount': 0,
        });

        for (int i = 0; i < _subControllers.length; i++) {
          final name = _subControllers[i]['name']!.text.trim();
          final icon = _subControllers[i]['icon']!.text.trim();
          if (name.isNotEmpty) {
            await fs.addSubcategory(catId, {
              'name': name,
              'icon': icon.isEmpty ? '📌' : icon,
              'order': i,
              'promptCount': 0,
            });
          }
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEdit ? 'Category updated!' : 'Category added!'),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final previewColor = Helpers.hexToColor(_colorCtrl.text);

    return Scaffold(
      backgroundColor: AppColors.lightScaffold,

      appBar: GradientAppBar(
        title: _isEdit ? 'EDIT CATEGORY' : 'ADD CATEGORY',
        showBack: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── PREVIEW CARD ───
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: previewColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: previewColor.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _iconCtrl.text.isNotEmpty ? _iconCtrl.text : '📁',
                        style: const TextStyle(fontSize: 40),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'PREVIEW',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textHint,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // ─── CATEGORY DETAILS SECTION ───
              Text(
                'Category Details',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 16),

              CustomTextField(
                hint: 'e.g. Portrait Photography',
                label: 'Name',
                prefixIcon: Icons.label_outline,
                controller: _nameCtrl,
                validator: (v) => Validators.required(v, 'Name'),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hint: 'e.g. 📸',
                      label: 'Emoji Icon',
                      prefixIcon: Icons.emoji_emotions_outlined,
                      controller: _iconCtrl,
                      validator: (v) => Validators.required(v, 'Icon'),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      hint: 'e.g. #3949AB',
                      label: 'Color Hex',
                      prefixIcon: Icons.color_lens_outlined,
                      controller: _colorCtrl,
                      validator: (v) => Validators.required(v, 'Color'),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Text(
                'QUICK COLORS',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textHint,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  '#1A237E', '#3949AB', '#5C6BC0', '#7E57C2', // Dark Blues / Purples
                  '#9575CD', '#42A5F5', '#0288D1', '#0097A7', // Light Blues / Teals
                  '#7B1FA2', '#455A64', '#1E88E5', '#673AB7', // Mix Professional
                ].map((hex) {
                  final c = Helpers.hexToColor(hex);
                  final isSelected = _colorCtrl.text.toUpperCase() == hex.toUpperCase();
                  return GestureDetector(
                    onTap: () {
                      setState(() => _colorCtrl.text = hex);
                    },
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Colors.white : Colors.transparent,
                          width: 3,
                        ),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: c.withOpacity(0.4),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                        ],
                      ),
                      child: isSelected
                          ? const Icon(Icons.check_rounded, color: Colors.white, size: 20)
                          : null,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 40),

              // ─── SUBCATEGORIES SECTION ───
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subcategories',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _addSubcategoryField,
                    icon: const Icon(
                      Icons.add_circle_rounded,
                      size: 20,
                      color: AppColors.royalBlue, // Updated to Blue
                    ),
                    label: Text(
                      'ADD NEW',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.royalBlue,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              if (_subControllers.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: AppColors.lightInput,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border.withOpacity(0.5)),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.subdirectory_arrow_right_rounded,
                        size: 40,
                        color: AppColors.indigo.withOpacity(0.3),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No subcategories added',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

              ...List.generate(_subControllers.length, (i) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.royalBlue.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: previewColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'SUB ${i + 1}',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                color: previewColor,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => _removeSubcategoryField(i),
                            icon: const Icon(Icons.delete_outline_rounded, color: AppColors.error, size: 22),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: CustomTextField(
                              hint: 'Name',
                              controller: _subControllers[i]['name'],
                              validator: (v) => Validators.required(v, 'Name'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 1,
                            child: CustomTextField(
                              hint: '📌',
                              controller: _subControllers[i]['icon'],
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 40),

              CustomButton(
                text: _isEdit ? 'UPDATE CATEGORY' : 'SAVE CATEGORY',
                icon: Icons.check_circle_outline_rounded,
                isLoading: _saving,
                onPressed: _save,
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}