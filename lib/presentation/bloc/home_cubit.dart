import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_terbaru.dart';
import '../../../domain/usecases/get_populer.dart'; // Tetap butuh Populer All untuk Featured
import '../../../domain/usecases/get_populer_manga.dart';
import '../../../domain/usecases/get_populer_manhwa.dart';
import '../../../domain/usecases/get_populer_manhua.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetTerbaru getTerbaru;
  final GetPopuler getPopuler; // Gunakan ini untuk Featured Section
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

  Future<void> fetchHomeData() async {
    emit(HomeLoading());
    try {
      // Menjalankan semua request secara paralel untuk performa maksimal di Redmibook kamu
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
      emit(HomeError(e.toString()));
    }
  }
}
