import '../repositories/comic_repository.dart';
import '../entities/comic_detail.dart';

class GetDetailKomik {
  final ComicRepository repository;

  GetDetailKomik(this.repository);

  Future<dynamic> execute(String slug) {
    return repository.getDetailComic(slug);
  }
}
