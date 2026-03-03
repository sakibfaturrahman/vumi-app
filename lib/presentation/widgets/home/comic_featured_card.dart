import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../domain/entities/comic.dart';

class ComicFeaturedCard extends StatelessWidget {
  final List<Comic> data;
  const ComicFeaturedCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox();

    return VxSwiper.builder(
      itemCount: data.length,
      aspectRatio: 2.1,
      enlargeCenterPage: true,
      autoPlay: true,
      itemBuilder: (context, index) {
        final comic = data[index];

        return VxBox(
              child: HStack([
                VStack([
                  "New Episode!".text.orange500.bold.xs
                      .make()
                      .box
                      .white
                      .roundedFull
                      .padding(
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      )
                      .make(),
                  10.heightBox,
                  comic.title.text.xl2.extraBold.black
                      .maxLines(2)
                      .ellipsis
                      .make(),
                  5.heightBox,
                  // Menampilkan Type (Manga/Manhwa/Manhua) sebagai sub-title
                  "${comic.type ?? 'Manga'} • Friend".text.gray600.semiBold.sm
                      .make(),
                ]).p16().expand(),

                // SISI KANAN: Foto Karakter/Thumbnail
                VxBox(
                      child: Image.network(
                        comic.thumbnail,
                        fit: BoxFit.cover,
                        errorBuilder: (context, e, s) =>
                            const Icon(Icons.image, color: Colors.grey),
                      ),
                    )
                    .width(context.screenWidth * 0.3)
                    .height(double.infinity)
                    .clip(Clip.antiAlias)
                    .make(),
              ]),
            )
            .withGradient(
              LinearGradient(
                colors: [Colors.orange.shade100, Colors.orange.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            )
            .roundedLg
            .clip(Clip.antiAlias)
            .margin(const EdgeInsets.symmetric(horizontal: 5))
            .make()
            .onTap(() {
              // Navigasi ke detail menggunakan slug
              debugPrint("Detail: ${comic.slug}");
            });
      },
    );
  }
}
