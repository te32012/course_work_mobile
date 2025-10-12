

import 'package:course_work/model/entity/film.dart';


final class AboutFilmWithFilmState {

  final Film _film;
  AboutFilmWithFilmState(this._film);
  
  Film get film => _film;
  
  @override
  List<Object?> get props => [_film];
}