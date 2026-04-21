import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';
import '../../config/app_routes.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({Key? key, required this.currentIndex}) : super(key: key);

  static const List<String> _routes = [
    AppRoutes.home,
    AppRoutes.categories,
    AppRoutes.search,
    AppRoutes.favorites,
    AppRoutes.settings,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        gradient: AppColors.navGradient, // ✅ Matches Top Bar
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildItem(context, 0, Icons.home_rounded, "home"),
            _buildItem(context, 1, Icons.grid_view_rounded, "browse"),
            _buildItem(context, 2, Icons.search_rounded, "search"),
            _buildItem(context, 3, Icons.bookmark_rounded, "saved"),
            _buildItem(context, 4, Icons.settings_rounded, "settings"),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index, IconData icon, String label) {
    final bool isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(context, _routes[index]),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          // ✅ Glass Pill effect for active tab
          color: isActive ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            if (isActive)
              Text(
                label,
                style: GoogleFonts.raleway(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              )
          ],
        ),
      ),
    );
  }
}