import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../widgets/detail/detail_info_card.dart';

class DetailPage extends StatelessWidget {
  // Gunakan dynamic agar fleksibel, tapi pastikan cara aksesnya benar
  final dynamic data;
  const DetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. Header Gambar ala Avatar
          SliverAppBar(
            expandedHeight: 450,
            pinned: true,
            leading: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ).p12().onTap(() => Navigator.pop(context)),
            flexibleSpace: FlexibleSpaceBar(
              background: ZStack([
                // Gunakan .thumbnail karena data biasanya berupa Object Model
                Image.network(
                  data.thumbnail,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 50).centered(),
                ),
                // Efek gradasi agar menyatu dengan background sistem
                VxBox()
                    .withGradient(
                      LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          context.theme.scaffoldBackgroundColor,
                        ],
                      ),
                    )
                    .make()
                    .whFull(context),
              ]),
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              VStack([
                // 2. Header Info (Gunakan . untuk akses property)
                HStack([
                  data.title.text.xl3.bold.make().expand(),
                  const Icon(Icons.share_outlined, size: 20),
                ]),
                // Tampilkan slug atau info tambahan sebagai sub-judul
                "Vumi Comic Reader".text.amber600.semiBold.make(),

                24.heightBox,

                // 3. Tombol Aksi Orange
                HStack([
                  "Baca Sekarang".text.white.bold
                      .make()
                      .centered()
                      .box
                      .amber600
                      .roundedLg
                      .make()
                      .h(50)
                      .expand()
                      .onTap(() {
                        /* Logic navigasi ke chapter pertama */
                      }),
                  12.widthBox,
                  const Icon(Icons.bookmark_border, size: 28).box
                      .border(color: context.theme.dividerColor)
                      .roundedLg
                      .p12
                      .make(),
                ]),

                24.heightBox,

                // 4. Info Section Sederhana (Karena data list baru berisi info dasar)
                "Informasi".text.lg.bold.make(),
                10.heightBox,
                VStack([
                  _buildRowInfo("Type", data.type ?? "Manga"),
                  _buildRowInfo("Update", data.updateStatus ?? "Baru saja"),
                ]).p16().box.color(context.theme.cardColor).roundedSM.make(),

                24.heightBox,
                "Sinopsis".text.lg.bold.make(),
                10.heightBox,
                (data.description ?? "Belum ada sinopsis untuk komik ini.")
                    .toString()
                    .text
                    .gray500
                    .maxLines(4)
                    .ellipsis
                    .make(),

                // Menggunakan widget yang dipisah jika datanya Map,
                // Jika tidak ada data.info, kita sembunyikan atau beri default
                if (data is Map && data['info'] != null)
                  DetailInfoCard(info: Map<String, String>.from(data['info'])),

                30.heightBox,
                "Daftar Chapter".text.lg.bold.make().pOnly(bottom: 16),

                // Placeholder jika data chapters belum dimuat (karena ini halaman detail awal)
                "Klik 'Baca Sekarang' untuk memuat chapter.".text.italic.gray400
                    .make()
                    .centered(),

                150.heightBox,
              ]).p16(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildRowInfo(String label, String value) {
    return HStack([
      label.text.gray500.make().w(80),
      ": ".text.make(),
      value.text.semiBold.make().expand(),
    ]).pOnly(bottom: 8);
  }
}
