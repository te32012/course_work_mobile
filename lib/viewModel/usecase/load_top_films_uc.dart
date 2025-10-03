

import 'package:course_work/model/entity/film.dart';
import 'package:course_work/viewModel/service/film_service.dart';

class LoadTopFilmsUc {
  final FilmService _filmService;
  LoadTopFilmsUc(this._filmService);
  Future<List<Film>> use() {
    return _filmService.loadTopFilms();
  }
}