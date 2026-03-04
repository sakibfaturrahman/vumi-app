class ComicDetailModel {
  final String title;
  final String alternativeTitle;
  final String description;
  final String thumbnail;
  final List<String> genres;
  final Map<String, String> info;
  final List<Map<String, dynamic>> chapters;

  ComicDetailModel({
    required this.title,
    required this.alternativeTitle,
    required this.description,
    required this.thumbnail,
    required this.genres,
    required this.info,
    required this.chapters,
  });

  factory ComicDetailModel.fromJson(Map<String, dynamic> json) {
    return ComicDetailModel(
      // Handling title kosong dari JSON kamu
      title: json['title'] == ""
          ? (json['info']['Judul Komik'] ?? "")
          : json['title'],
      alternativeTitle: json['alternativeTitle'] ?? '',
      description: json['description'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      // Pastikan genres di-cast ke List<String>
      genres: List<String>.from(json['genres'] ?? []),
      // Pastikan info di-cast ke Map<String, String>
      info: Map<String, String>.from(json['info'] ?? {}),
      chapters: List<Map<String, dynamic>>.from(json['chapters'] ?? []),
    );
  }
}
