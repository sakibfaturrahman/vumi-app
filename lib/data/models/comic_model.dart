import '../../domain/entities/comic.dart';

class ComicModel {
  final String title;
  final String slug;
  final String thumbnail;
  final String? type;
  final String? genre;
  final String? updateStatus;
  final String? description;

  ComicModel({
    required this.title,
    required this.slug,
    required this.thumbnail,
    this.type,
    this.genre,
    this.updateStatus,
    this.description,
  });

  factory ComicModel.fromJson(Map<String, dynamic> json) {
    return ComicModel(
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      type: json['type'],
      genre: json['genre'],
      updateStatus: json['updateStatus'],
      description: json['description'],
    );
  }

  // Fungsi konversi dari Model ke Entity
  Comic toEntity() {
    return Comic(
      title: title,
      slug: slug,
      thumbnail: thumbnail,
      type: type,
      genre: genre,
      updateStatus: updateStatus,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'slug': slug,
      'thumbnail': thumbnail,
      'type': type,
      'genre': genre,
      'updateStatus': updateStatus,
      'description': description,
    };
  }
}
