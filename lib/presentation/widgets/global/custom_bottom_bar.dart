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
    return VxBox(
          child: HStack([
            _navItem(context, Icons.home_rounded, "Home", 0),
            _navItem(context, Icons.history_rounded, "Riwayat", 1),
            _navItem(context, Icons.favorite_rounded, "Disukai", 2),
            _navItem(context, Icons.explore_rounded, "Jelajahi", 3),
          ], alignment: MainAxisAlignment.spaceAround).p8(),
        )
        .white // Warna background (akan otomatis menyesuaikan jika pakai context.theme.cardColor)
        .withRounded(value: 20) // Membuat sudut membulat
        .shadowXl // Memberikan shadow tebal agar terlihat melayang
        .make()
        .p16(); // Padding luar agar tidak menempel ke pinggir layar
  }

  Widget _navItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
  ) {
    bool isActive = currentIndex == index;

    return VStack([
      Icon(icon, color: isActive ? Vx.indigo600 : Vx.gray400, size: 26),
      label.text.color(isActive ? Vx.indigo600 : Vx.gray400).sm.semiBold.make(),
    ], crossAlignment: CrossAxisAlignment.center).onTap(() => onTap(index));
  }
}
