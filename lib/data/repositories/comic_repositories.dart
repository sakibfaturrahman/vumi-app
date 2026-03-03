import '../../data/models/comic_model.dart';

abstract class ComicRepository {
  Future<List<ComicModel>> getTerbaru();
  Future<List<ComicModel>> getPopulerAll();
  Future<List<ComicModel>> getPopulerManga();
  Future<List<ComicModel>> getPopulerManhwa();
  Future<List<ComicModel>> getPopulerManhua();
  Future<List<ComicModel>> searchComic(String query);
  Future<ComicModel> getDetailComic(String slug);
}
