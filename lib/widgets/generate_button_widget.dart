import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/prompt_model.dart';
import '../../services/firestore_service.dart';
import '../utils/deep_link_helper.dart';

class GenerateButtonWidget extends StatefulWidget {
  final PromptModel prompt;
  final VoidCallback? onCopied;
  final bool showRedirect;
  final GenerateButtonStyle style;

  const GenerateButtonWidget({
    Key? key,
    required this.prompt,
    this.onCopied,
    this.showRedirect = true,
    this.style = GenerateButtonStyle.primary,
  }) : super(key: key);

  @override
  State<GenerateButtonWidget> createState() => _GenerateButtonWidgetState();
}

class _GenerateButtonWidgetState extends State<GenerateButtonWidget>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: _buildButton(),
    );
  }

  Widget _buildButton() {
    switch (widget.style) {
      case GenerateButtonStyle.primary:
        return _buildPrimaryButton();
      case GenerateButtonStyle.secondary:
        return _buildSecondaryButton();
      case GenerateButtonStyle.text:
        return _buildTextButton();
    }
  }

  Widget _buildPrimaryButton() {
    final label = widget.showRedirect ? '⚡ Generate This' : '📋 Copy Prompt';
    final loadingLabel = widget.showRedirect ? 'Generating...' : 'Copying...';
    final icon = widget.showRedirect ? Icons.auto_awesome : Icons.copy_rounded;

    return ElevatedButton.icon(
      onPressed: _isLoading ? null : _handleGenerate,
      icon: _isLoading
          ? const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      )
          : Icon(icon, size: 20),
      label: Text(
        _isLoading ? loadingLabel : label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
      ),
    );
  }

  Widget _buildSecondaryButton() {
    return OutlinedButton.icon(
      onPressed: _isLoading ? null : _handleGenerate,
      icon: _isLoading
          ? const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(strokeWidth: 2),
      )
          : const Icon(Icons.copy, size: 18),
      label: Text(
        _isLoading ? 'Copying...' : 'Copy Prompt',
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide(color: Theme.of(context).primaryColor, width: 2),
      ),
    );
  }

  Widget _buildTextButton() {
    return TextButton.icon(
      onPressed: _isLoading ? null : _handleGenerate,
      icon: const Icon(Icons.copy, size: 16),
      label: const Text('Copy', style: TextStyle(fontSize: 14)),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Future<void> _handleGenerate() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // Haptic feedback
    HapticFeedback.mediumImpact();

    // Animation
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    try {
      // 1. Copy to clipboard
      await Clipboard.setData(ClipboardData(text: widget.prompt.text));

      // 2. Increment usage count in Firebase
      await FirestoreService().incrementPromptUsage(widget.prompt.id);

      // 3. Show success feedback
      if (mounted) {
        _showSuccessSnackbar();
      }

      // 4. Callback
      widget.onCopied?.call();

      // 5. Redirect to AI platform (if enabled)
      if (widget.showRedirect && widget.prompt.platformKey.isNotEmpty) {
        await Future.delayed(const Duration(milliseconds: 500));

        if (mounted) {
          await DeepLinkHelper.openAIPlatform(
            widget.prompt.platformKey,
            context: context,
          );
        }
      }
    } catch (e) {
      debugPrint('❌ Generate error: $e');
      if (mounted) {
        _showErrorSnackbar();
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSuccessSnackbar() {
    final platformName = widget.prompt.platform;
    final message = widget.showRedirect
        ? 'Prompt copied! Opening $platformName...'
        : 'Prompt copied to clipboard!';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showErrorSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.error, color: Colors.white),
            SizedBox(width: 12),
            Expanded(child: Text('Failed to copy prompt')),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

enum GenerateButtonStyle {
  primary,
  secondary,
  text,
}
