import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/app_colors.dart';
import '../../config/app_constants.dart';
import '../../models/category_model.dart';
import '../../models/subcategory_model.dart';
import '../../models/prompt_model.dart';
import '../../providers/prompt_provider.dart';
import '../../services/firestore_service.dart';
import '../../services/cloudinary_service.dart';
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
  final _videoUrlCtrl = TextEditingController();

  String? _selectedCategoryId;
  String? _selectedCategoryName;
  String? _selectedSubcategoryId;
  String? _selectedSubcategoryName;
  String _selectedPlatform = AppConstants.aiPlatforms.first;
  
  // Example specific states
  bool _hasExample = false;
  String _exampleType = 'none'; // 'image', 'video', 'none'
  String? _existingImageUrl;
  File? _selectedImage;
  bool _isFeatured = false;

  List<SubcategoryModel> _subcategories = [];
  bool _loadingSubs = false;
  bool _saving = false;
  bool get _isEdit => widget.prompt != null;

  final _picker = ImagePicker();
  final _cloudinary = CloudinaryService();

  @override
  void initState() {
    super.initState();
    if (_isEdit) {
      final p = widget.prompt!;
      _titleCtrl.text = p.title;
      _textCtrl.text = p.text;
      _descCtrl.text = p.description;
      _selectedCategoryId = p.categoryId;
      _selectedCategoryName = p.categoryName;
      _selectedSubcategoryId = p.subcategoryId;
      _selectedSubcategoryName = p.subcategoryName;
      _selectedPlatform = p.platform;
      
      _hasExample = p.hasExample;
      _exampleType = p.exampleType;
      _existingImageUrl = p.exampleImageUrl;
      _videoUrlCtrl.text = p.exampleVideoUrl ?? '';
      _isFeatured = p.isFeatured;
      
      _loadSubcategories(p.categoryId);
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _textCtrl.dispose();
    _descCtrl.dispose();
    _videoUrlCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _exampleType = 'image';
        _hasExample = true;
      });
    }
  }

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

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text('Please select a category'), backgroundColor: AppColors.error),
      );
      return;
    }

    setState(() => _saving = true);
    final fs = FirestoreService();

    try {
      String? imageUrl = _existingImageUrl;
      String? thumbUrl;

      // Upload image to Cloudinary if a new one is selected
      if (_selectedImage != null && _exampleType == 'image') {
        final result = await _cloudinary.uploadImage(
          _selectedImage!,
          folder: 'nexora/prompts',
          fileName: 'prompt_${DateTime.now().millisecondsSinceEpoch}',
        );
        if (result.success) {
          imageUrl = result.url;
          thumbUrl = result.thumbnailUrl;
        } else {
          throw Exception('Image upload failed: ${result.errorMessage}');
        }
      }

      final data = {
        'title': _titleCtrl.text.trim(),
        'text': _textCtrl.text.trim(),
        'description': _descCtrl.text.trim(),
        'categoryId': _selectedCategoryId,
        'subcategoryId': _selectedSubcategoryId ?? '',
        'categoryName': _selectedCategoryName ?? '',
        'subcategoryName': _selectedSubcategoryName ?? '',
        'platform': _selectedPlatform,
        'hasExample': _hasExample,
        'exampleType': _exampleType,
        'exampleImageUrl': _exampleType == 'image' ? imageUrl : null,
        'exampleVideoUrl': _exampleType == 'video' ? _videoUrlCtrl.text.trim() : null,
        'thumbnailUrl': _exampleType == 'image' ? (thumbUrl ?? imageUrl) : null,
        'isFeatured': _isFeatured,
        'platformKey': _selectedPlatform.toLowerCase().replaceAll(' ', '_'),
        'platformUrl': _getPlatformUrl(_selectedPlatform),
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
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error),
        );
        setState(() => _saving = false);
      }
    }
  }

  String _getPlatformUrl(String platform) {
    const urls = {
      'Midjourney': 'https://discord.com/channels/midjourney',
      'Leonardo AI': 'https://app.leonardo.ai/',
      'DALL-E 3': 'https://labs.openai.com/',
      'Stable Diffusion XL': 'https://stablediffusionweb.com/',
      'ChatGPT': 'https://chat.openai.com/',
    };
    return urls[platform] ?? '';
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
              Text(
                'Prompt Details',
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
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
              
              Text(
                'Category & Platform',
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 16),
              StreamBuilder<List<CategoryModel>>(
                stream: Provider.of<PromptProvider>(context).categoriesStream,
                builder: (context, snap) {
                  final cats = snap.data ?? [];
                  return _dropdownWrapper(
                    DropdownButtonFormField<String>(
                      value: _selectedCategoryId,
                      hint: Text('Select Category', style: GoogleFonts.poppins(color: AppColors.textHint)),
                      items: cats.map((c) => DropdownMenuItem(value: c.id, child: Text('${c.icon} ${c.name}'))).toList(),
                      onChanged: (v) {
                        final cat = cats.firstWhere((c) => c.id == v);
                        setState(() {
                          _selectedCategoryId = v;
                          _selectedCategoryName = cat.name;
                          _selectedSubcategoryId = null;
                        });
                        _loadSubcategories(v!);
                      },
                      validator: (v) => v == null ? 'Select a category' : null,
                      decoration: const InputDecoration(border: InputBorder.none, prefixIcon: Icon(Icons.category_rounded, color: AppColors.royalBlue)),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              if (_subcategories.isNotEmpty)
                _dropdownWrapper(
                  DropdownButtonFormField<String>(
                    value: _selectedSubcategoryId,
                    hint: Text('Select Subcategory', style: GoogleFonts.poppins(color: AppColors.textHint)),
                    items: _subcategories.map((s) => DropdownMenuItem(value: s.id, child: Text('${s.icon} ${s.name}'))).toList(),
                    onChanged: (v) {
                      final sub = _subcategories.firstWhere((s) => s.id == v);
                      setState(() {
                        _selectedSubcategoryId = v;
                        _selectedSubcategoryName = sub.name;
                      });
                    },
                    decoration: const InputDecoration(border: InputBorder.none, prefixIcon: Icon(Icons.subdirectory_arrow_right_rounded, color: AppColors.lavender)),
                  ),
                ),
              const SizedBox(height: 16),
              _dropdownWrapper(
                DropdownButtonFormField<String>(
                  value: _selectedPlatform,
                  items: AppConstants.aiPlatforms.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                  onChanged: (v) => setState(() => _selectedPlatform = v!),
                  decoration: const InputDecoration(border: InputBorder.none, prefixIcon: Icon(Icons.smart_toy_rounded, color: AppColors.violet)),
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'Example Media',
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                title: Text('Include Example Result', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                value: _hasExample,
                activeColor: AppColors.royalBlue,
                onChanged: (v) => setState(() => _hasExample = v),
              ),
              if (_hasExample) ...[
                Row(
                  children: [
                    _mediaTypeChip('Image', 'image'),
                    const SizedBox(width: 12),
                    _mediaTypeChip('Video', 'video'),
                  ],
                ),
                const SizedBox(height: 16),
                if (_exampleType == 'image') ...[
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.lightInput,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border.withOpacity(0.4)),
                      ),
                      child: _selectedImage != null
                          ? ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.file(_selectedImage!, fit: BoxFit.cover))
                          : (_existingImageUrl != null
                              ? ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.network(_existingImageUrl!, fit: BoxFit.cover))
                              : Column(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.add_a_photo_rounded, size: 40, color: AppColors.textHint), Text('Upload Example Image')])),
                    ),
                  ),
                ] else if (_exampleType == 'video') ...[
                  CustomTextField(
                    hint: 'Video URL (Direct link to .mp4 or similar)',
                    label: 'Video URL',
                    prefixIcon: Icons.play_circle_fill_rounded,
                    controller: _videoUrlCtrl,
                  ),
                ],
              ],
              const SizedBox(height: 24),

              Text(
                'Prompt Content',
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
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
              const SizedBox(height: 12),
              CheckboxListTile(
                title: Text('Feature this prompt on home screen', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                value: _isFeatured,
                activeColor: AppColors.royalBlue,
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                onChanged: (v) => setState(() => _isFeatured = v ?? false),
              ),
              const SizedBox(height: 40),
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

  Widget _dropdownWrapper(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightInput,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.4)),
      ),
      child: child,
    );
  }

  Widget _mediaTypeChip(String label, String type) {
    final isSelected = _exampleType == type;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (val) => setState(() => _exampleType = type),
      selectedColor: AppColors.royalBlue.withOpacity(0.2),
      labelStyle: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
        color: isSelected ? AppColors.royalBlue : AppColors.textSecondary,
      ),
    );
  }
}