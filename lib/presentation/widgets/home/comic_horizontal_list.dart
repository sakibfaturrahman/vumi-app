import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../domain/entities/comic.dart';

class ComicHorizontalList extends StatelessWidget {
  final List<Comic> data;
  const ComicHorizontalList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty)
      return "Tidak ada data".text.gray500.make().centered().h(220);

    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final comic = data[index];
          return VStack([
            // Image Card dengan Shadow halus
            VxBox(
                  child: Image.network(
                    comic.thumbnail,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported).centered(),
                  ),
                ).roundedLg
                .clip(Clip.antiAlias)
                .width(130)
                .height(180)
                .shadowSm
                .make(),

            8.heightBox,

            // Judul dan Type (Manga/Manhwa)
            comic.title.text.sm.bold.maxLines(1).ellipsis.make().w(130),
            (comic.type ?? "Comic").text.xs.gray500.make(),
          ]).p4().onTap(() {
            // Navigator ke halaman detail nanti
            print("Detail: ${comic.slug}");
          });
        },
      ),
    );
  }
}
