import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constant/api_constants.dart';
import 'dart:developer' as dev;

abstract class RemoteDataSource {
  Future<List<dynamic>> fetchTerbaru();
  Future<List<dynamic>> fetchPopulerAll();
  Future<List<dynamic>> fetchPopulerManga(); // Tambahan untuk endpoint spesifik
  Future<List<dynamic>> fetchPopulerManhwa();
  Future<List<dynamic>> fetchPopulerManhua();
  Future<List<dynamic>> searchManga(String query);
  Future<Map<String, dynamic>> fetchDetailManga(String slug);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  // Fungsi Helper Utama untuk mencegah error Subtype Map vs List
  List<dynamic> _handleResponse(http.Response response, String context) {
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedData = json.decode(response.body);
      final dynamic result = decodedData['data'];

      if (result is List) {
        return result;
      } else if (result is Map) {
        // Jika API mengirim Map kategori, kita ambil semua isinya jadi satu List
        final List<dynamic> combined = [];
        result.forEach((key, value) {
          if (value is List) combined.addAll(value);
        });
        return combined;
      }
      return []; // Return list kosong jika data tidak dikenali
    } else {
      throw Exception("Gagal di $context: Status ${response.statusCode}");
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

  // Implementasi untuk endpoint spesifik sesuai gambar API kamu
  @override
  Future<List<dynamic>> fetchPopulerManga() async {
    final response = await client.get(
      Uri.parse("${ApiConstants.baseUrl}/komik-populer/manga"),
    );
    return _handleResponse(response, "manga");
  }

  @override
  Future<List<dynamic>> fetchPopulerManhwa() async {
    final response = await client.get(
      Uri.parse("${ApiConstants.baseUrl}/komik-populer/manhwa"),
    );
    return _handleResponse(response, "manhwa");
  }

  @override
  Future<List<dynamic>> fetchPopulerManhua() async {
    final response = await client.get(
      Uri.parse("${ApiConstants.baseUrl}/komik-populer/manhua"),
    );
    return _handleResponse(response, "manhua");
  }

  @override
  Future<List<dynamic>> fetchTerbaru() async {
    try {
      final response = await client.get(Uri.parse(ApiConstants.terbaru));
      return _handleResponse(response, "terbaru");
    } catch (e) {
      dev.log("Error fetchTerbaru: $e");
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

  @override
  Future<Map<String, dynamic>> fetchDetailManga(String slug) async {
    try {
      final response = await client.get(
        Uri.parse("${ApiConstants.detailKomik}/$slug"),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body)['data'] as Map<String, dynamic>;
      }
      throw Exception("Detail Gagal");
    } catch (e) {
      dev.log("Error Detail: $e");
      rethrow;
    }
  }
}
