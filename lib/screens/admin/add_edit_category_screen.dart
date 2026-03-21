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

  // ✅ Subcategory controllers
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
      _colorCtrl.text = '#FF6B9D';
    }
  }

  // ✅ Load existing subcategories for editing
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

  // ✅ Add new subcategory field
  void _addSubcategoryField() {
    setState(() {
      _subControllers.add({
        'name': TextEditingController(),
        'icon': TextEditingController(text: '📌'),
      });
    });
  }

  // ✅ Remove subcategory field
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

  // ✅ Save category + subcategories
  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    try {
      final fs = FirestoreService();

      if (_isEdit) {
        // Update category
        await fs.updateCategory(widget.category!.id, {
          'name': _nameCtrl.text.trim(),
          'icon': _iconCtrl.text.trim(),
          'color': _colorCtrl.text.trim(),
        });

        // Update subcategories
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
        // Create new category
        final catId = await fs.addCategoryAndGetId({
          'name': _nameCtrl.text.trim(),
          'icon': _iconCtrl.text.trim(),
          'color': _colorCtrl.text.trim(),
          'order': 0,
          'promptCount': 0,
        });

        // Add subcategories
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
            content: Text(
              _isEdit ? 'Category updated!' : 'Category added!',
            ),
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
      backgroundColor: Colors.white,

      appBar: GradientAppBar(
        title: _isEdit ? 'Edit Category' : 'Add Category',
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
                    color: previewColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: previewColor.withOpacity(0.3),
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
                        'Preview',
                        style: GoogleFonts.raleway(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textHint,
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
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 16),

              CustomTextField(
                hint: 'Category Name',
                label: 'Name',
                prefixIcon: Icons.label_outline,
                controller: _nameCtrl,
                validator: (v) => Validators.required(v, 'Name'),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  // Icon Field
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
                  // Color Field
                  Expanded(
                    child: CustomTextField(
                      hint: 'e.g. #FF6B9D',
                      label: 'Color Hex',
                      prefixIcon: Icons.color_lens_outlined,
                      controller: _colorCtrl,
                      validator: (v) => Validators.required(v, 'Color'),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // ─── COLOR PRESETS ───
              Text(
                'Quick Colors',
                style: GoogleFonts.raleway(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textHint,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  '#FF6B9D', '#4A90D9', '#FF85C2', '#FF9F43',
                  '#A55EEA', '#E74C3C', '#26de81', '#FD9644',
                  '#F7B731', '#FC5C65', '#2D98DA', '#45AAF2',
                  '#4B7BEC', '#20BF6B', '#FED330', '#FF6348',
                ].map((hex) {
                  final c = Helpers.hexToColor(hex);
                  final isSelected = _colorCtrl.text.toUpperCase() == hex.toUpperCase();
                  return GestureDetector(
                    onTap: () {
                      setState(() => _colorCtrl.text = hex);
                    },
                    child: Container(
                      width: 36,
                      height: 36,
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
                              color: c.withOpacity(0.6),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                        ],
                      ),
                      child: isSelected
                          ? const Icon(Icons.check_rounded, color: Colors.white, size: 18)
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
                    style: GoogleFonts.playfairDisplay(
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
                      color: AppColors.lightCoral,
                    ),
                    label: Text(
                      'Add',
                      style: GoogleFonts.raleway(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.lightCoral,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              if (_subControllers.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.lightInput,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.border.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.subdirectory_arrow_right_rounded,
                        size: 32,
                        color: AppColors.sage.withOpacity(0.5),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'No subcategories added',
                        style: GoogleFonts.raleway(
                          fontSize: 13,
                          color: AppColors.textHint,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tap "Add" to create subcategories',
                        style: GoogleFonts.raleway(
                          fontSize: 11,
                          color: AppColors.textHint,
                        ),
                      ),
                    ],
                  ),
                ),

              // ─── SUBCATEGORY FIELDS ───
              ...List.generate(_subControllers.length, (i) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.border.withOpacity(0.4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Header with number and delete
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: previewColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Sub ${i + 1}',
                              style: GoogleFonts.raleway(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: previewColor,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _removeSubcategoryField(i),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: AppColors.error.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.close_rounded,
                                size: 18,
                                color: AppColors.error,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Name and Icon Fields
                      Row(
                        children: [
                          // Subcategory Name
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              controller: _subControllers[i]['name'],
                              style: GoogleFonts.raleway(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Subcategory name',
                                hintStyle: GoogleFonts.raleway(
                                  color: AppColors.textHint,
                                  fontSize: 13,
                                ),
                                filled: true,
                                fillColor: AppColors.lightInput,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                            ),
                          ),

                          const SizedBox(width: 12),

                          // Subcategory Icon
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: _subControllers[i]['icon'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                hintText: '📌',
                                filled: true,
                                fillColor: AppColors.lightInput,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 40),

              // ─── SAVE BUTTON ───
              CustomButton(
                text: _isEdit ? 'UPDATE CATEGORY' : 'ADD CATEGORY',
                icon: Icons.save_rounded,
                isLoading: _saving,
                onPressed: _save,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}