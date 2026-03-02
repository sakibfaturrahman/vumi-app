import 'package:equatable/equatable.dart';

class Comic extends Equatable {
  final String title;
  final String slug;
  final String thumbnail;
  final String? type;
  final String? genre;
  final String? updateStatus;

  const Comic({
    required this.title,
    required this.slug,
    required this.thumbnail,
    this.type,
    this.genre,
    this.updateStatus,
  });

  @override
  List<Object?> get props => [
    title,
    slug,
    thumbnail,
    type,
    genre,
    updateStatus,
  ];
}
