import '../entities/comic.dart';
import '../repositories/comic_repository.dart';

class GetTerbaru {
  final ComicRepository repository;

  GetTerbaru(this.repository);

  Future<List<Comic>> execute() {
    return repository.getTerbaru();
  }
}
