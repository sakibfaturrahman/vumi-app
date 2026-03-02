import '../../domain/repositories/comic_repository.dart';
import '../../domain/entities/comic.dart';
import '../datasources/remote_datasource.dart';
import '../models/comic_model.dart';

class ComicRepositoryImpl implements ComicRepository {
  final RemoteDataSource remoteDataSource;

  // Constructor untuk menyuntikkan (inject) datasource ke repository
  ComicRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Comic>> getTerbaru() async {
    // Memanggil data mentah (JSON) dari datasource
    final List<dynamic> jsonList = await remoteDataSource.fetchTerbaru();

    // Mapping: Mengubah setiap Map JSON menjadi objek ComicModel
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

  @override
  Future<List<Comic>> searchComic(String query) async {
    // Mengarahkan parameter query ke datasource
    final List<dynamic> jsonList = await remoteDataSource.searchManga(query);
    return jsonList
        .map((json) => ComicModel.fromJson(json).toEntity())
        .toList();
  }

  @override
  Future<Comic> getDetailComic(String slug) async {
    // Mengambil data detail komik tunggal berdasarkan slug
    final Map<String, dynamic> json = await remoteDataSource.fetchDetailManga(
      slug,
    );
    return ComicModel.fromJson(json).toEntity();
  }
}
