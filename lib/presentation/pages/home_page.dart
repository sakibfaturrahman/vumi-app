import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import '../bloc/home_cubit.dart';
import '../bloc/home_state.dart';
import '../widgets/home/featured_section.dart';
import '../widgets/home/comic_horizontal_list.dart';
import '../widgets/home/comic_featured_card.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const CircularProgressIndicator().centered();
        } else if (state is HomeError) {
          // UI Error interaktif jika terjadi kendala pada server Vercel
          return VStack([
            "Ups, terjadi kesalahan!".text.semiBold.make(),
            10.heightBox,
            state.message.text.red500.center.make(),
            20.heightBox,
            "Coba Lagi".text.white
                .make()
                .centered()
                .box
                .amber600
                .roundedSM
                .px16
                .py8
                .make()
                .onTap(() => context.read<HomeCubit>().fetchHomeData()),
          ]).centered().p20();
        } else if (state is HomeLoaded) {
          return RefreshIndicator(
            color: Vx.amber500,
            onRefresh: () => context.read<HomeCubit>().fetchHomeData(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: VStack([
                // 1. Banner Headline (Featured dari Manga Terpopuler)
                FeaturedSection(data: state.manga.take(5).toList()),

                "Baru Update".text.xl2.bold.make().p16(),

                // 2. Section Baru Update (Navigasi detail)
                ComicFeaturedCard(data: state.terbaru).onTap(() {
                  if (state.terbaru.isNotEmpty) {
                    _navigateToDetail(context, state.terbaru.first);
                  }
                }),

                // 3. Manga Section - Menyuntikkan label 'Manga' secara manual
                _buildSectionTitle(context, "Manga Terpopuler"),
                ComicHorizontalList(data: state.manga, categoryLabel: "Manga"),

                // 4. Manhwa Section - Menyuntikkan label 'Manhwa' secara manual
                _buildSectionTitle(context, "Manhwa Terpopuler"),
                ComicHorizontalList(
                  data: state.manhwa,
                  categoryLabel: "Manhwa",
                ),

                // 5. Manhua Section - Menyuntikkan label 'Manhua' secara manual
                _buildSectionTitle(context, "Manhua Terpopuler"),
                ComicHorizontalList(
                  data: state.manhua,
                  categoryLabel: "Manhua",
                ),

                // Memberikan ruang ekstra agar tidak tertutup bottom navigation
                150.heightBox,
              ]),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  // Helper untuk navigasi antar halaman
  void _navigateToDetail(BuildContext context, dynamic comicData) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailPage(data: comicData)),
    );
  }

  // UI Title Section dengan aksen warna Amber
  Widget _buildSectionTitle(BuildContext context, String title) {
    return HStack([
      title.text.xl.bold.make().expand(),
      HStack([
        "Lihat Semua".text.amber500.semiBold.sm.make(),
        4.widthBox,
        const Icon(Icons.arrow_forward_ios, size: 12, color: Vx.amber500),
      ]).onTap(() {
        // Rencana navigasi ke list kategori di masa depan
      }),
    ], alignment: MainAxisAlignment.spaceBetween).wFull(context).p16();
  }
}
