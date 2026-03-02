import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ComicHorizontalList extends StatelessWidget {
  final String endpoint;
  const ComicHorizontalList({super.key, required this.endpoint});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: 10,
        itemBuilder: (context, index) {
          return VStack([
            // Image Card
            VxBox().color(Vx.gray200).roundedLg.width(130).height(170).make(),

            5.heightBox,

            // Judul
            "Judul Komik".text.sm.bold.maxLines(1).ellipsis.make().w(130),
            "Chapter 120".text.xs.gray500.make(),
          ]).p4();
        },
      ),
    );
  }
}
