import '../entities/comic.dart';

abstract class ComicRepository {
  Future<List<Comic>> getTerbaru();
  Future<List<Comic>> getPopulerAll();
  Future<List<Comic>> searchComic(String query);
  Future<Comic> getDetailComic(String slug);
}
