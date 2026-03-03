import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import '../bloc/home_cubit.dart';
import '../bloc/home_state.dart';
import '../widgets/home/featured_section.dart';
import '../widgets/home/comic_horizontal_list.dart';
import '../widgets/home/comic_featured_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const CircularProgressIndicator().centered();
        } else if (state is HomeError) {
          return state.message.text.red500.make().centered().p20();
        } else if (state is HomeLoaded) {
          return RefreshIndicator(
            onRefresh: () => context.read<HomeCubit>().fetchHomeData(),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: VStack([
                // Featured Section menggunakan data Manga sebagai headline
                FeaturedSection(data: state.manga.take(5).toList()),

                "Baru Update".text.xl2.bold.make().p16(),
                ComicFeaturedCard(data: state.terbaru),

                _buildSectionTitle("Manga Terpopuler"),
                ComicHorizontalList(data: state.manga),

                _buildSectionTitle("Manhwa Terpopuler"),
                ComicHorizontalList(data: state.manhwa),

                _buildSectionTitle("Manhua Terpopuler"),
                ComicHorizontalList(data: state.manhua),

                120.heightBox,
              ]),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return HStack([
      title.text.xl.bold.make(),
      "Lihat Semua".text.indigo600.semiBold.make().onTap(() {}),
    ], alignment: MainAxisAlignment.spaceBetween).p16();
  }
}
