class ComicModel {
  final String title;
  final String slug;
  final String thumbnail;
  final String? type; // Ini yang akan membedakan Manga, Manhwa, atau Manhua
  final String? genre;
  final String? updateStatus;
  final String? description;
  final Map<String, dynamic>? chapters;

  ComicModel({
    required this.title,
    required this.slug,
    required this.thumbnail,
    this.type,
    this.genre,
    this.updateStatus,
    this.description,
    this.chapters,
  });

  // Factory untuk merubah JSON dari API VUMI menjadi Objek Dart
  factory ComicModel.fromJson(Map<String, dynamic> json) {
    return ComicModel(
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      type: json['type'], // Contoh: "Manga", "Manhwa", atau "Manhua"
      genre: json['genre'],
      updateStatus: json['updateStatus'],
      description: json['description'],
      chapters: json['chapters'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'slug': slug,
      'thumbnail': thumbnail,
      'type': type,
      'genre': genre,
      'update_status': updateStatus,
      'description': description,
      'chapters': chapters,
    };
  }
}
