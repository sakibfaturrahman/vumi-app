class ComicDetail {
  final String title;
  final String description;
  final String thumbnail;
  final List<String> genres;
  final Map<String, String> info;
  final List<dynamic> chapters;

  ComicDetail({
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.genres,
    required this.info,
    required this.chapters,
  });
}
