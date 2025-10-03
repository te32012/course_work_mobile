

import 'package:course_work/model/entity/film.dart';
import 'package:equatable/equatable.dart';

sealed class AboutFilmState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AboutFilmEmptyState extends AboutFilmState {

}

final class AboutFilmWithFilmState extends AboutFilmState {

  final Film _film;
  AboutFilmWithFilmState(this._film);
  
  Film get film => _film;
  
  @override
  List<Object?> get props => [_film];
}