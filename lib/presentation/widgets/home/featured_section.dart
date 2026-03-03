import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../domain/entities/comic.dart';

class FeaturedSection extends StatelessWidget {
  final List<Comic> data;
  const FeaturedSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox();

    return VxSwiper.builder(
      itemCount: data.length,
      aspectRatio: 16 / 9,
      enlargeCenterPage: true,
      autoPlay: true,
      itemBuilder: (context, index) {
        final comic = data[index];
        return VxBox(
              child: ZStack([
                // Gambar dari API
                Image.network(
                  comic.thumbnail,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  // Error handling jika gambar gagal load
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 50).centered(),
                ),

                // Gradient Overlay agar teks terbaca (ala Tailwind)
                VxBox()
                    .withGradient(
                      LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.transparent,
                        ],
                      ),
                    )
                    .make()
                    .wFull(context)
                    .hFull(context),

                // Teks Informasi Komik
                VStack([
                  "Trending".text.white.xs.semiBold
                      .make()
                      .px8()
                      .py2()
                      .box
                      .indigo600
                      .roundedSM
                      .make(),
                  5.heightBox,
                  comic.title.text.white.xl2.bold.maxLines(1).ellipsis.make(),
                  (comic.updateStatus ?? "Ongoing").text.white.sm.make(),
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
