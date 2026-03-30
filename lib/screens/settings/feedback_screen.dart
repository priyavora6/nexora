import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../config/app_colors.dart';
import '../../widgets/layout/gradient_app_bar.dart';

class FeedbackScreen extends StatefulWidget {
  final bool isRateUsMode; 

  const FeedbackScreen({Key? key, this.isRateUsMode = false}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final InAppReview inAppReview = InAppReview.instance;
  double _rating = 0;
  final _feedbackCtrl = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _handleAction() async {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PLEASE SELECT A RATING!'), backgroundColor: Colors.orange),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    if (_rating >= 4) {
      // 🌟 Professional: Request In-App Review for happy users
      if (await inAppReview.isAvailable()) {
        await inAppReview.requestReview();
      }
      _showSuccessToast("THANK YOU FOR THE ${_rating.toInt()}-STAR VIBE! 🚀");
    } else {
      // 📝 Damage Control: Save internal feedback for unhappy users
      // TODO: Add your Firestore logic here
      _showSuccessToast("FEEDBACK RECEIVED. WE WILL IMPROVE! 💪");
    }

    setState(() => _isSubmitting = false);
    Navigator.pop(context);
  }

  void _showSuccessToast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppColors.success, behavior: SnackBarBehavior.floating),
    );
  }

  @override
  void dispose() {
    _feedbackCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: GradientAppBar(
        title: widget.isRateUsMode ? 'RATE US' : 'FEEDBACK',
        showBack: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Icon(
              widget.isRateUsMode ? Icons.stars_rounded : Icons.chat_bubble_outline_rounded,
              size: 80,
              color: AppColors.royalBlue,
            ),
            const SizedBox(height: 24),
            Text(
              widget.isRateUsMode ? "HOW'S YOUR EXPERIENCE?" : "SEND US YOUR THOUGHTS",
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900, letterSpacing: -0.5),
            ),
            const SizedBox(height: 12),
            Text(
              "Your input helps us make Nexora better every day.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 48),

            // ─── STAR RATING ───
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              unratedColor: Colors.grey[200],
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(Icons.star_rounded, color: Colors.amber),
              onRatingUpdate: (rating) => setState(() => _rating = rating),
            ),

            const SizedBox(height: 40),

            // ─── CONDITIONAL FEEDBACK FIELD ───
            if (_rating > 0)
              TextField(
                controller: _feedbackCtrl,
                maxLines: 4,
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  hintText: _rating >= 4 ? "WHAT DO YOU LOVE ABOUT NEXORA?" : "TELL US WHAT WE CAN IMPROVE...",
                  hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 11, fontWeight: FontWeight.w800),
                  filled: true,
                  fillColor: AppColors.lightInput,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.all(20),
                ),
              ),

            const SizedBox(height: 40),

            // ─── SUBMIT BUTTON ───
            SizedBox(
              width: double.infinity,
              height: 56,
              child: Container(
                decoration: BoxDecoration(
                  gradient: _rating > 0 ? AppColors.buttonGradient : null,
                  color: _rating > 0 ? null : Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ElevatedButton(
                  onPressed: _rating > 0 && !_isSubmitting ? _handleAction : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text(
                          'SUBMIT',
                          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1)
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}