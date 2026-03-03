import '../entities/comic.dart';
import '../repositories/comic_repository.dart';

class GetPopulerManga {
  final ComicRepository repository;

  GetPopulerManga(this.repository);

  Future<List<Comic>> execute() async {
    try {
      // Kita asumsikan repository punya fungsi khusus atau kita filter di sini
      final allPopuler = await repository.getPopulerAll();
      return allPopuler.where((e) => e.type?.toLowerCase() == "manga").toList();
    } catch (e) {
      return []; // Kembalikan list kosong jika terjadi error
    }
  }
}
