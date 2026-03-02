import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../widgets/home/featured_section.dart';
import '../widgets/home/comic_horizontal_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: VStack([
        // 1. Card Paling Atas (Komik Populer All)
        const FeaturedSection(),

        // 2. Section Komik Terbaru (Baru Update)
        "Baru Update".text.xl2.bold.make().p16(),
        const ComicHorizontalList(endpoint: 'terbaru'),

        // 3. Section Manga Populer
        _buildSectionTitle("Manga Terpopuler"),
        const ComicHorizontalList(endpoint: 'manga'),

        // 4. Section Manhwa Populer
        _buildSectionTitle("Manhwa Terpopuler"),
        const ComicHorizontalList(endpoint: 'manhwa'),

        // 5. Section Manhua Populer
        _buildSectionTitle("Manhua Terpopuler"),
        const ComicHorizontalList(endpoint: 'manhua'),

        // Beri spasi bawah agar tidak tertutup Bottom Bar
        100.heightBox,
      ]),
    );
  }

  Widget _buildSectionTitle(String title) {
    return HStack([
      title.text.xl.bold.make(),
      "Lihat Semua".text.indigo600.semiBold.make().onTap(() {}),
    ], alignment: MainAxisAlignment.spaceBetween).p16();
  }
}
