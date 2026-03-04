import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constant/api_constants.dart';
import 'dart:developer' as dev;

abstract class RemoteDataSource {
  Future<List<dynamic>> fetchTerbaru();
  Future<List<dynamic>> fetchPopulerAll();
  Future<List<dynamic>> fetchPopulerManga();
  Future<List<dynamic>> fetchPopulerManhwa();
  Future<List<dynamic>> fetchPopulerManhua();
  Future<List<dynamic>> searchManga(String query);
  Future<Map<String, dynamic>> fetchDetailManga(String slug);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  /// Helper untuk memproses response List komik (Terbaru, Populer, Search)
  List<dynamic> _handleResponse(http.Response response, String context) {
    if (response.statusCode == 200) {
      final dynamic decodedData = json.decode(response.body);

      // Cek jika response langsung berupa List
      if (decodedData is List) {
        return decodedData;
      }

      // Cek jika response menggunakan wrapper 'data' (Standar Express kamu)
      if (decodedData is Map<String, dynamic>) {
        final dynamic result = decodedData['data'];

        if (result is List) {
          return result;
        } else if (result is Map) {
          final List<dynamic> combined = [];
          result.forEach((key, value) {
            if (value is List) combined.addAll(value);
          });
          return combined;
        }
      }

      dev.log("[$context] Struktur data tidak dikenali: $decodedData");
      return [];
    } else {
      dev.log("[$context] Server Error: ${response.statusCode}");
      throw Exception("Gagal memuat data $context");
    }
  }

  @override
  Future<Map<String, dynamic>> fetchDetailManga(String slug) async {
    try {
      // Validasi slug sebelum melakukan request untuk mencegah ENOTFOUND
      if (slug.trim().isEmpty) {
        dev.log("Error: Attempted to fetch detail with empty slug");
        throw Exception("Slug komik tidak ditemukan");
      }

      final url = "${ApiConstants.detailKomik}/$slug";
      dev.log("Fetching Detail: $url"); // Log URL untuk debugging di Redmibook

      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> decoded = json.decode(response.body);
        if (decoded['status'] == true && decoded['data'] != null) {
          return decoded['data'] as Map<String, dynamic>;
        }
      }

      dev.log("Detail Error [${response.statusCode}]: ${response.body}");
      throw Exception("Gagal mengambil detail komik dari server");
    } catch (e) {
      dev.log("Exception fetchDetailManga: $e");
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> fetchTerbaru() async {
    try {
      final response = await client.get(Uri.parse(ApiConstants.terbaru));
      return _handleResponse(response, "Terbaru");
    } catch (e) {
      dev.log("Error fetchTerbaru: $e");
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> fetchPopulerManga() async {
    try {
      final response = await client.get(Uri.parse(ApiConstants.popularManga));
      return _handleResponse(response, "Populer Manga");
    } catch (e) {
      dev.log("Error fetchPopulerManga: $e");
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> fetchPopulerManhwa() async {
    try {
      final response = await client.get(Uri.parse(ApiConstants.popularManhwa));
      return _handleResponse(response, "Populer Manhwa");
    } catch (e) {
      dev.log("Error fetchPopulerManhwa: $e");
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> fetchPopulerManhua() async {
    try {
      final response = await client.get(Uri.parse(ApiConstants.popularManhua));
      return _handleResponse(response, "Populer Manhua");
    } catch (e) {
      dev.log("Error fetchPopulerManhua: $e");
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> fetchPopulerAll() async {
    try {
      final response = await client.get(Uri.parse(ApiConstants.popularAll));
      return _handleResponse(response, "Populer All");
    } catch (e) {
      dev.log("Error fetchPopulerAll: $e");
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> searchManga(String query) async {
    try {
      final response = await client.get(
        Uri.parse("${ApiConstants.search}?q=$query"),
      );
      return _handleResponse(response, "Search");
    } catch (e) {
      dev.log("Error searchManga: $e");
      rethrow;
    }
  }
}
