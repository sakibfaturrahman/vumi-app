import '../entities/comic.dart';
import '../repositories/comic_repository.dart';

class SearchComic {
  final ComicRepository repository;

  SearchComic(this.repository);

  Future<List<Comic>> execute(String query) {
    return repository.searchComic(query);
  }
}
