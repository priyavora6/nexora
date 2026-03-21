import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
        // ✅ Soft, light overlay instead of dark
          Container(
            color: Colors.white.withOpacity(0.8), // Glass-like white effect
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: AppColors.lightCoral, // Theme primary color
                    strokeWidth: 3,
                  ),
                  SizedBox(height: 16),
                  // Optional: You could add a "Loading..." text here
                ],
              ),
            ),
          ),
      ],
    );
  }
}