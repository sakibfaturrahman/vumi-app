import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double systemNavPadding = MediaQuery.of(context).padding.bottom;

    return VxBox(
          child: HStack([
            _navItem(context, Icons.home_rounded, "Home", 0),
            _navItem(context, Icons.history_rounded, "Riwayat", 1),
            _navItem(context, Icons.favorite_rounded, "Disukai", 2),
            _navItem(context, Icons.explore_rounded, "Jelajahi", 3),
          ], alignment: MainAxisAlignment.spaceAround),
        )
        .color(context.theme.cardColor)
        .roundedLg
        .shadow2xl
        .margin(
          EdgeInsets.only(
            bottom: systemNavPadding > 0 ? systemNavPadding : 16,
            left: 16,
            right: 16,
            top: 10,
          ),
        )
        .make();
  }

  Widget _navItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
  ) {
    bool isActive = currentIndex == index;

    // PERBAIKAN: Menggunakan Theme.of(context) untuk cek Dark Mode
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final activeColor = Vx.amber500;
    final inactiveColor = isDarkMode ? Vx.gray500 : Vx.gray400;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.bounceOut,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? activeColor.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: VStack([
        AnimatedScale(
          scale: isActive ? 1.2 : 1.0,
          duration: const Duration(milliseconds: 300),
          child: Icon(
            icon,
            color: isActive ? activeColor : inactiveColor,
            size: 24,
          ),
        ),
        4.heightBox,
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            color: isActive ? activeColor : inactiveColor,
            fontSize: 10,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
          child: Text(label),
        ),
      ], crossAlignment: CrossAxisAlignment.center),
    ).onTap(() => onTap(index));
  }
}
