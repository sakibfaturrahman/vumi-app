import '../entities/comic.dart';
import '../repositories/comic_repository.dart';

class GetPopuler {
  final ComicRepository repository;

  GetPopuler(this.repository);

  Future<List<Comic>> execute() async {
    try {
      final result = await repository.getPopulerAll();
      // Pastikan mengembalikan list kosong [] jika null
      return result ?? [];
    } catch (e) {
      return []; // Return list kosong jika error agar UI tidak crash
    }
  }
}
