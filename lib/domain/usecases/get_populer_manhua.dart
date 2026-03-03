import '../entities/comic.dart';
import '../repositories/comic_repository.dart';

class GetPopulerManhua {
  final ComicRepository repository;

  GetPopulerManhua(this.repository);

  Future<List<Comic>> execute() async {
    try {
      // Mengambil data khusus kategori Manhua dari repository
      return await repository.getPopulerManhua();
    } catch (e) {
      return [];
    }
  }
}
