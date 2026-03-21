import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isOutlined;
  final IconData? icon;
  final double? width;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.icon,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: width ?? double.infinity,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), // ✅ Perfect pill shape
          // ✅ Matches Top & Bottom Nav Gradient
          gradient: isOutlined ? null : AppColors.navGradient,
          border: isOutlined
              ? Border.all(color: AppColors.lightCoral, width: 2)
              : null,
          boxShadow: isOutlined
              ? []
              : [
            BoxShadow(
              color: AppColors.lightCoral.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  text,
                  style: GoogleFonts.raleway( // ✅ Modern clean font for buttons
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: isOutlined ? AppColors.lightCoral : Colors.white,
                    letterSpacing: 1.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 10),
                Icon(
                  icon,
                  color: isOutlined ? AppColors.lightCoral : Colors.white,
                  size: 18,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}