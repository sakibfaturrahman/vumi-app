import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          VxBox(
                child: HStack([
                  // 1. Search Bar Panjang
                  VxBox(
                        child: HStack([
                          const Icon(
                            Icons.search_rounded,
                            color: Vx.gray500,
                            size: 20,
                          ),
                          8.widthBox,
                          "Cari komik favoritmu...".text.gray500
                              .make()
                              .expand(), // expand agar teks mengambil sisa ruang
                        ]).px16(),
                      )
                      .height(45)
                      .color(context.isDarkMode ? Vx.gray800 : Vx.gray100)
                      .roundedLg // Memberikan efek rounded
                      .make()
                      .expand(), // expand agar Box search mengambil ruang maksimal ke kiri

                  12.widthBox, // Spasi antara search dan menu
                  // 2. Tombol Titik Tiga (More Menu)
                  const Icon(Icons.more_vert_rounded, size: 28).onTap(() {
                    // Aksi ketika titik tiga diklik (misal buka drawer atau popup)
                    Scaffold.of(context).openEndDrawer();
                  }),
                ]).p16(),
              ).white
              .color(
                context.theme.scaffoldBackgroundColor,
              ) // Beradaptasi dengan Dark/Light mode
              .make(),
    );
  }

  // Menentukan tinggi header agar bisa digunakan di properti appBar Scaffold
  @override
  Size get preferredSize => const Size.fromHeight(70);
}
