import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_terbaru.dart';
import '../../../domain/usecases/get_populer.dart';
import '../../../domain/usecases/get_populer_manga.dart';
import '../../../domain/usecases/get_populer_manhwa.dart';
import '../../../domain/usecases/get_populer_manhua.dart';
import '../pages/detail_page.dart'; // Import halaman detail
import 'home_state.dart';
import 'dart:developer' as dev;

class HomeCubit extends Cubit<HomeState> {
  final GetTerbaru getTerbaru;
  final GetPopuler getPopuler;
  final GetPopulerManga getPopulerManga;
  final GetPopulerManhwa getPopulerManhwa;
  final GetPopulerManhua getPopulerManhua;

  HomeCubit({
    required this.getTerbaru,
    required this.getPopuler,
    required this.getPopulerManga,
    required this.getPopulerManhwa,
    required this.getPopulerManhua,
  }) : super(HomeInitial());

  /// Mengambil data untuk halaman Home secara paralel
  Future<void> fetchHomeData() async {
    emit(HomeLoading());
    try {
      final results = await Future.wait([
        getTerbaru.execute(),
        getPopuler.execute(),
        getPopulerManga.execute(),
        getPopulerManhwa.execute(),
        getPopulerManhua.execute(),
      ]);

      emit(
        HomeLoaded(
          terbaru: results[0],
          populer: results[1],
          manga: results[2],
          manhwa: results[3],
          manhua: results[4],
        ),
      );
    } catch (e) {
      dev.log("Fetch Home Error: $e");
      emit(HomeError(e.toString()));
    }
  }

  /// Fungsi Navigasi: Digunakan saat kartu komik di-klik
  void selectComic(BuildContext context, dynamic comic) {
    // 1. Ambil slug dengan aman sesuai JSON Express kamu
    final String? slug = comic['mangaSlug'] ?? comic['slug'];

    if (slug == null || slug.isEmpty) {
      dev.log("Error: Slug tidak ditemukan pada data komik ini");
      return;
    }

    dev.log("Navigating to detail for: $slug");

    // 2. Navigasi langsung ke DetailPage dengan membawa data dasar
    // Nantinya di DetailPage, kamu bisa memanggil API detail_komik/{slug}
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailPage(data: comic)),
    );
  }
}
