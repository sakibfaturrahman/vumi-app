class ApiConstants {
  // Ganti dengan IP laptop Redmibook kamu jika testing di HP fisik
  // atau pakai https://api-vumi-scrap.vercel.app jika sudah deploy
  static const String baseUrl = "https://api-vumi-scrap.vercel.app/api/vumi";

  // Endpoints
  static const String terbaru = "$baseUrl/terbaru";
  static const String rekomendasi = "$baseUrl/rekomendasi";
  static const String search = "$baseUrl/search";
  static const String popularAll = "$baseUrl/komik-populer/all";
  static const String popularManga = "$baseUrl/komik-populer/manga";
  static const String popularManhwa = "$baseUrl/komik-populer/manhwa";
  static const String popularManhua = "$baseUrl/komik-populer/manhua";
  static const String detailKomik = "$baseUrl/detail-komik"; // + /{slug}
  static const String bacaChapter = "$baseUrl/baca-chapter"; // + /{slug}/{chap}
  static const String genreAll = "$baseUrl/genre-all";
}
