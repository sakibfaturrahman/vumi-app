import '../../domain/repositories/comic_repository.dart';
import '../../domain/entities/comic.dart';
import '../../domain/entities/comic_detail.dart';
import '../datasources/remote_datasource.dart';
import '../models/comic_model.dart';
import '../models/comic_detail_model.dart';

class ComicRepositoryImpl implements ComicRepository {
  final RemoteDataSource remoteDataSource;

  ComicRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Comic>> getTerbaru() async {
    final List<dynamic> jsonList = await remoteDataSource.fetchTerbaru();
    return jsonList
        .map((json) => ComicModel.fromJson(json).toEntity())
        .toList();
  }

  @override
  Future<List<Comic>> getPopulerAll() async {
    final List<dynamic> jsonList = await remoteDataSource.fetchPopulerAll();
    return jsonList
        .map((json) => ComicModel.fromJson(json).toEntity())
        .toList();
  }

  // --- Implementasi Fungsi Baru Berdasarkan Endpoint Spesifik ---

  @override
  Future<List<Comic>> getPopulerManga() async {
    final List<dynamic> jsonList = await remoteDataSource.fetchPopulerManga();
    return jsonList
        .map((json) => ComicModel.fromJson(json).toEntity())
        .toList();
  }

  @override
  Future<List<Comic>> getPopulerManhwa() async {
    final List<dynamic> jsonList = await remoteDataSource.fetchPopulerManhwa();
    return jsonList
        .map((json) => ComicModel.fromJson(json).toEntity())
        .toList();
  }

  @override
  Future<List<Comic>> getPopulerManhua() async {
    final List<dynamic> jsonList = await remoteDataSource.fetchPopulerManhua();
    return jsonList
        .map((json) => ComicModel.fromJson(json).toEntity())
        .toList();
  }

  // -----------------------------------------------------------

  @override
  Future<List<Comic>> searchComic(String query) async {
    final List<dynamic> jsonList = await remoteDataSource.searchManga(query);
    return jsonList
        .map((json) => ComicModel.fromJson(json).toEntity())
        .toList();
  }

  @override
  Future<ComicDetail> getDetailComic(String slug) async {
    final Map<String, dynamic> json = await remoteDataSource.fetchDetailManga(
      slug,
    );
    final model = ComicDetailModel.fromJson(json);

    return ComicDetail(
      title: model.title,
      description: model.description,
      thumbnail: model.thumbnail,
      genres: model.genres,
      info: model.info,
      chapters: model.chapters,
    );
  }
}
