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
                // =============================
                // SISI KIRI: DETAIL TEKS
                // =============================
                VStack([
                  // =============================
                  // BADGE NEW EPISODE (FIXED)
                  // =============================
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // penting!
                      children: const [
                        Icon(
                          Icons.auto_awesome,
                          size: 12,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "New Episode!",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  12.heightBox,

                  comic.title.text.xl.extraBold.black
                      .maxLines(2)
                      .ellipsis
                      .tight
                      .make(),

                  6.heightBox,

                  "${comic.type ?? 'Manga'} • Friend".text.gray600.semiBold.xs
                      .make(),
                ], crossAlignment: CrossAxisAlignment.start).p16().expand(),

                // =============================
                // SISI KANAN: THUMBNAIL
                // =============================
                VxBox(
                      child: Image.network(
                        comic.thumbnail,
                        fit: BoxFit.cover,
                        errorBuilder: (context, e, s) =>
                            const Icon(Icons.image, color: Colors.grey),
                      ),
                    )
                    .width(context.screenWidth * 0.35)
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
              debugPrint("Detail: ${comic.slug}");
            });
      },
    );
  }
}
