import 'package:equatable/equatable.dart';
import '../../../domain/entities/comic.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Comic> terbaru;
  final List<Comic> populer; // Tambahkan field ini untuk Featured Section
  final List<Comic> manga;
  final List<Comic> manhwa;
  final List<Comic> manhua;

  HomeLoaded({
    required this.terbaru,
    required this.populer,
    required this.manga,
    required this.manhwa,
    required this.manhua,
  });

  @override
  List<Object?> get props => [terbaru, populer, manga, manhwa, manhua];
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
