import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constant/api_constants.dart';
import '../../core/utils/logger.dart';

abstract class RemoteDataSource {
  // Kontrak fungsi yang harus ada
  Future<List<dynamic>> fetchTerbaru();
  Future<List<dynamic>> fetchPopulerAll();
  Future<List<dynamic>> searchManga(String query);
  Future<Map<String, dynamic>> fetchDetailManga(String slug);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<dynamic>> fetchTerbaru() async {
    try {
      final response = await client.get(Uri.parse(ApiConstants.terbaru));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data']; // Mengambil array 'data' dari response API Vumi
      } else {
        throw Exception("Gagal mengambil data terbaru");
      }
    } catch (e) {
      VumiLogger.log("Error fetchTerbaru", error: e);
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> fetchPopulerAll() async {
    try {
      final response = await client.get(Uri.parse(ApiConstants.popularAll));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'];
      } else {
        throw Exception("Gagal mengambil data populer");
      }
    } catch (e) {
      VumiLogger.log("Error fetchPopulerAll", error: e);
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> searchManga(String query) async {
    try {
      // Menggunakan endpoint /api/vumi/search?q=
      final response = await client.get(
        Uri.parse("${ApiConstants.search}?q=$query"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'];
      } else {
        throw Exception("Pencarian gagal");
      }
    } catch (e) {
      VumiLogger.log("Error searchManga", error: e);
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> fetchDetailManga(String slug) async {
    try {
      // Menggunakan endpoint /api/vumi/detail-komik/{slug}
      final response = await client.get(
        Uri.parse("${ApiConstants.detailKomik}/$slug"),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body)['data'];
      } else {
        throw Exception("Gagal mengambil detail komik");
      }
    } catch (e) {
      VumiLogger.log("Error fetchDetailManga", error: e);
      rethrow;
    }
  }
}
