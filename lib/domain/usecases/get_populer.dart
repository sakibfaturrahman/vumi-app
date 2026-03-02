import '../entities/comic.dart';
import '../repositories/comic_repository.dart';

class GetPopuler {
  final ComicRepository repository;

  GetPopuler(this.repository);

  Future<List<Comic>> execute() {
    return repository.getPopulerAll();
  }
}
