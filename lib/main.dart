import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'presentation/bloc/home_cubit.dart';
import 'presentation/bloc/home_state.dart';
import 'presentation/widgets/home/featured_section.dart';
import 'presentation/widgets/home/comic_horizontal_list.dart';
import 'presentation/widgets/home/comic_featured_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          // Menggunakan loading yang lebih halus di tengah layar
          return const CircularProgressIndicator().centered();
        } else if (state is HomeError) {
          return VStack([
            "Gagal mengambil data".text.semiBold.make(),
            10.heightBox,
            state.message.text.red500.center.make(),
            20.heightBox,
            "Coba Lagi".text.white
                .make()
                .centered()
                .box
                .indigo600
                .roundedSM
                .px16
                .py8
                .make()
                .onTap(() => context.read<HomeCubit>().fetchHomeData()),
          ]).centered().p20();
        } else if (state is HomeLoaded) {
          return RefreshIndicator(
            // Fungsi refresh untuk memicu penarikan data ulang dari API Vercel
            onRefresh: () => context.read<HomeCubit>().fetchHomeData(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: VStack([
                // 1. Banner Headline (Carousel)
                FeaturedSection(data: state.manga.take(5).toList()),

                // 2. Section Card Panjang (Style My Hero Academia)
                "Baru Update".text.xl2.bold.make().p16(),
                ComicFeaturedCard(data: state.terbaru),

                // 3. Manga Section
                _buildSectionTitle(
                  context,
                  "Manga Terpopuler",
                  onSeeAll: () {
                    // Tambahkan navigasi ke halaman list manga di sini
                  },
                ),
                ComicHorizontalList(data: state.manga),

                // 4. Manhwa Section
                _buildSectionTitle(
                  context,
                  "Manhwa Terpopuler",
                  onSeeAll: () {
                    // Navigasi ke list manhwa
                  },
                ),
                ComicHorizontalList(data: state.manhwa),

                // 5. Manhua Section
                _buildSectionTitle(
                  context,
                  "Manhua Terpopuler",
                  onSeeAll: () {
                    // Navigasi ke list manhua
                  },
                ),
                ComicHorizontalList(data: state.manhua),

                // Memberikan ruang agar tidak tertutup Floating Bottom Bar
                150.heightBox,
              ]),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  // UI Title Section dengan tombol "Lihat Semua" di sisi kanan
  Widget _buildSectionTitle(
    BuildContext context,
    String title, {
    VoidCallback? onSeeAll,
  }) {
    return HStack([
      // Judul Section
      title.text.xl.bold.make().expand(),

      // Tombol Lihat Semua (Ganti ke Amber agar sinkron dengan badge)
      "Lihat Semua"
          .text
          .amber500 // <--- Ganti di sini
          .semiBold
          .sm
          .make()
          .onTap(onSeeAll ?? () {}),
    ], alignment: MainAxisAlignment.spaceBetween).wFull(context).p16();
  }
}
