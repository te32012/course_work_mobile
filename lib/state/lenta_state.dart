

import 'package:course_work/data/model/film.dart';
import 'package:course_work/data/repository/storage/favorite_film_repository.dart';
import 'package:equatable/equatable.dart';

sealed class LentaState extends Equatable {
  final bool isFaivorite;

  const LentaState(this.isFaivorite);
  
  void addFilms(List<Film> films);
  
  @override
  List<Object?> get props => [];
}

final class LentaEmptyState extends LentaState {
  const LentaEmptyState(super.isFaivorite);
  
  @override
  void addFilms(List<Film> films) => throw Exception();
}

final class LentaWithFilmsState extends LentaState {
  final List<Film> items;
  final FavoriteFilmRepository favoriteFilmRepository;

  const LentaWithFilmsState(super.isFaivorite, this.items, this.favoriteFilmRepository);

  @override
  List<Object?> get props => [items, favoriteFilmRepository];
  
  @override
  void addFilms(List<Film> films) => items.addAll(films);
}