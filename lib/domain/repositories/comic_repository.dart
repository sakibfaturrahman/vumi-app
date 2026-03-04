import '../entities/comic.dart';
import '../entities/comic_detail.dart';

abstract class ComicRepository {
  Future<List<Comic>> getTerbaru();
  Future<List<Comic>> getPopulerAll();
  Future<List<Comic>> getPopulerManga();
  Future<List<Comic>> getPopulerManhwa();
  Future<List<Comic>> getPopulerManhua();
  Future<List<Comic>> searchComic(String query);
  Future<ComicDetail> getDetailComic(String slug);
}
