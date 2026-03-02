import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return VxSwiper.builder(
      itemCount: 5, // Nanti dihubungkan ke data Populer All
      aspectRatio: 16 / 9,
      enlargeCenterPage: true,
      autoPlay: true,
      itemBuilder: (context, index) {
        return VxBox(
              child: ZStack([
                // Thumbnail dengan gradient overlay
                VxBox()
                    .color(Vx.gray300)
                    .make()
                    .wFull(context)
                    .hFull(context), // Placeholder
                // Teks Overlay di atas gambar
                VStack([
                  "Trending #1".text.white.xs.semiBold
                      .make()
                      .px8()
                      .py2()
                      .box
                      .indigo600
                      .roundedSM
                      .make(),
                  "Judul Komik Populer".text.white.xl2.bold.make(),
                  "S6E22 • Action".text.white.sm.make(),
                ]).p16().positioned(bottom: 0, left: 0, right: 0),
              ]),
            )
            .clip(Clip.antiAlias)
            .roundedLg
            .margin(const EdgeInsets.symmetric(horizontal: 5))
            .make();
      },
    );
  }
}
