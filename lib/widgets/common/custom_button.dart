import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final IconData? icon;
  final double? width;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.icon,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null || isLoading;

    return GestureDetector(
      onTap: isDisabled ? null : onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: width ?? double.infinity,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: (isOutlined || onPressed == null) ? null : AppColors.navGradient,
          color: onPressed == null ? Colors.grey[300] : (isOutlined ? Colors.transparent : null),
          border: isOutlined
              ? Border.all(color: onPressed == null ? Colors.grey[400]! : AppColors.royalBlue, width: 2)
              : null,
          boxShadow: (isOutlined || onPressed == null)
              ? []
              : [
            BoxShadow(
              color: AppColors.royalBlue.withOpacity(0.3),
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
                  style: GoogleFonts.raleway(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: isOutlined 
                        ? (onPressed == null ? Colors.grey[400] : AppColors.royalBlue) 
                        : (onPressed == null ? Colors.grey[600] : Colors.white),
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
                  color: isOutlined 
                      ? (onPressed == null ? Colors.grey[400] : AppColors.royalBlue) 
                      : (onPressed == null ? Colors.grey[600] : Colors.white),
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