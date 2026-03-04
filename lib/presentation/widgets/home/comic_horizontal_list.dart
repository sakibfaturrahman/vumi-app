import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../domain/entities/comic.dart';
import '../../pages/detail_page.dart';

class ComicHorizontalList extends StatelessWidget {
  final List<Comic> data;
  final String categoryLabel; // <--- Tambahkan parameter ini

  const ComicHorizontalList({
    super.key,
    required this.data,
    required this.categoryLabel, // <--- Wajib diisi dari HomePage
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return "Tidak ada data".text.gray500.make().centered().h(220);
    }

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final comic = data[index];
          return VStack([
            // Image Card
            VxBox(
                  child: Image.network(
                    comic.thumbnail,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                    ).centered(),
                  ),
                ).roundedLg
                .clip(Clip.antiAlias)
                .width(130)
                .height(180)
                .shadowSm
                .make(),

            8.heightBox,

            // Judul
            comic.title.text.sm.bold.maxLines(2).ellipsis.make().w(130),

            // Type Badge (Sekarang menggunakan label dari parameter HomePage)
            categoryLabel.text.xs.semiBold.amber600.make().pOnly(top: 2),
          ]).p4().onTap(() {
            // Navigasi ke Detail Page dengan membawa data entitas
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailPage(data: comic)),
            );
          });
        },
      ),
    );
  }
}
