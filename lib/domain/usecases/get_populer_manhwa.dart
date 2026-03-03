import '../entities/comic.dart';
import '../repositories/comic_repository.dart';

class GetPopulerManhwa {
  final ComicRepository repository;

  GetPopulerManhwa(this.repository);

  Future<List<Comic>> execute() async {
    try {
      // Mengambil data khusus kategori Manhwa dari repository
      return await repository.getPopulerManhwa();
    } catch (e) {
      return [];
    }
  }
}
