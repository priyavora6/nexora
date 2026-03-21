import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../config/app_constants.dart';
import '../../models/category_model.dart';
import '../../models/subcategory_model.dart';
import '../../models/prompt_model.dart';
import '../../providers/prompt_provider.dart';
import '../../services/firestore_service.dart';
import '../../utils/validators.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_textfield.dart';
import '../../widgets/layout/gradient_app_bar.dart';

class AddEditPromptScreen extends StatefulWidget {
  final PromptModel? prompt;
  const AddEditPromptScreen({Key? key, this.prompt}) : super(key: key);

  @override
  State<AddEditPromptScreen> createState() => _AddEditPromptScreenState();
}

class _AddEditPromptScreenState extends State<AddEditPromptScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _textCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  String? _selectedCategoryId;
  String? _selectedCategoryName;
  String? _selectedSubcategoryId;
  String? _selectedSubcategoryName;
  String _selectedPlatform = AppConstants.aiPlatforms.first;

  List<SubcategoryModel> _subcategories = [];
  bool _loadingSubs = false;
  bool _saving = false;
  bool get _isEdit => widget.prompt != null;

  @override
  void initState() {
    super.initState();
    if (_isEdit) {
      _titleCtrl.text = widget.prompt!.title;
      _textCtrl.text = widget.prompt!.text;
      _descCtrl.text = widget.prompt!.description;
      _selectedCategoryId = widget.prompt!.categoryId;
      _selectedCategoryName = widget.prompt!.categoryName;
      _selectedSubcategoryId = widget.prompt!.subcategoryId;
      _selectedSubcategoryName = widget.prompt!.subcategoryName;
      _selectedPlatform = widget.prompt!.platform;
      _loadSubcategories(widget.prompt!.categoryId);
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _textCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  // ✅ Load subcategories when category changes
  Future<void> _loadSubcategories(String categoryId) async {
    setState(() {
      _loadingSubs = true;
      _subcategories = [];
    });

    try {
      final fs = FirestoreService();
      final subs = await fs.getSubcategoriesList(categoryId);
      if (mounted) {
        setState(() {
          _subcategories = subs;
          _loadingSubs = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loadingSubs = false);
      }
    }
  }

  // ✅ Save prompt
  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select a category'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_subcategories.isNotEmpty && _selectedSubcategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select a subcategory'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _saving = true);
    final fs = FirestoreService();

    try {
      final data = {
        'title': _titleCtrl.text.trim(),
        'text': _textCtrl.text.trim(),
        'description': _descCtrl.text.trim(),
        'categoryId': _selectedCategoryId,
        'subcategoryId': _selectedSubcategoryId ?? '',
        'categoryName': _selectedCategoryName ?? '',
        'subcategoryName': _selectedSubcategoryName ?? '',
        'platform': _selectedPlatform,
      };

      if (_isEdit) {
        await fs.updatePrompt(widget.prompt!.id, data);
      } else {
        await fs.addPrompt(data);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEdit ? 'Prompt updated!' : 'Prompt added!'),
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
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: GradientAppBar(
        title: _isEdit ? 'Edit Prompt' : 'Add Prompt',
        showBack: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── TITLE ───
              Text(
                'Prompt Details',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 20),

              CustomTextField(
                hint: 'Prompt Title',
                label: 'Title',
                prefixIcon: Icons.title_rounded,
                controller: _titleCtrl,
                validator: (v) => Validators.required(v, 'Title'),
              ),

              const SizedBox(height: 20),

              // ─── CATEGORY DROPDOWN ───
              Text(
                'Category & Platform',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 16),

              StreamBuilder<List<CategoryModel>>(
                stream: Provider.of<PromptProvider>(context).categoriesStream,
                builder: (context, snap) {
                  final cats = snap.data ?? [];
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightInput,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.border.withOpacity(0.4),
                      ),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: _selectedCategoryId,
                      hint: Text(
                        'Select Category',
                        style: GoogleFonts.poppins(
                          color: AppColors.textHint,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.category_rounded,
                          color: AppColors.lightCoral,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      dropdownColor: Colors.white,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      items: cats.map((c) {
                        return DropdownMenuItem(
                          value: c.id,
                          child: Text('${c.icon} ${c.name}'),
                        );
                      }).toList(),
                      onChanged: (v) {
                        final cat = cats.firstWhere((c) => c.id == v);
                        setState(() {
                          _selectedCategoryId = v;
                          _selectedCategoryName = cat.name;
                          _selectedSubcategoryId = null;
                          _selectedSubcategoryName = null;
                        });
                        _loadSubcategories(v!);
                      },
                      validator: (v) => v == null ? 'Select a category' : null,
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              // ─── SUBCATEGORY DROPDOWN ───
              if (_loadingSubs)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(
                      color: AppColors.lightCoral,
                      strokeWidth: 2,
                    ),
                  ),
                ),

              if (!_loadingSubs && _subcategories.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightInput,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.border.withOpacity(0.4),
                    ),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _selectedSubcategoryId,
                    hint: Text(
                      'Select Subcategory',
                      style: GoogleFonts.poppins(
                        color: AppColors.textHint,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.subdirectory_arrow_right_rounded,
                        color: AppColors.sage,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    dropdownColor: Colors.white,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    items: _subcategories.map((s) {
                      return DropdownMenuItem(
                        value: s.id,
                        child: Text('${s.icon} ${s.name}'),
                      );
                    }).toList(),
                    onChanged: (v) {
                      final sub = _subcategories.firstWhere((s) => s.id == v);
                      setState(() {
                        _selectedSubcategoryId = v;
                        _selectedSubcategoryName = sub.name;
                      });
                    },
                    validator: (v) {
                      if (_subcategories.isNotEmpty && v == null) {
                        return 'Select a subcategory';
                      }
                      return null;
                    },
                  ),
                ),

              if (!_loadingSubs && _selectedCategoryId != null && _subcategories.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.lightInput,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 18,
                        color: AppColors.textHint,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'No subcategories in this category',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.textHint,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 16),

              // ─── PLATFORM DROPDOWN ───
              Container(
                decoration: BoxDecoration(
                  color: AppColors.lightInput,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.border.withOpacity(0.4),
                  ),
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedPlatform,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.smart_toy_rounded,
                      color: AppColors.sweetPeony,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  dropdownColor: Colors.white,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  items: AppConstants.aiPlatforms.map((p) {
                    return DropdownMenuItem(
                      value: p,
                      child: Text(p),
                    );
                  }).toList(),
                  onChanged: (v) => setState(() => _selectedPlatform = v!),
                ),
              ),

              const SizedBox(height: 24),

              // ─── PROMPT CONTENT ───
              Text(
                'Prompt Content',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 16),

              CustomTextField(
                hint: 'Write your full prompt text here...',
                label: 'Prompt Text',
                prefixIcon: Icons.text_fields_rounded,
                controller: _textCtrl,
                maxLines: 8,
                validator: (v) => Validators.required(v, 'Prompt text'),
              ),

              const SizedBox(height: 16),

              CustomTextField(
                hint: 'Short description (optional)',
                label: 'Description',
                prefixIcon: Icons.description_outlined,
                controller: _descCtrl,
                maxLines: 3,
              ),

              const SizedBox(height: 40),

              // ─── SAVE BUTTON ───
              CustomButton(
                text: _isEdit ? 'UPDATE PROMPT' : 'ADD PROMPT',
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
