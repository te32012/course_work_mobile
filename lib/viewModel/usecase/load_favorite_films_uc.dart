
import 'package:course_work/model/entity/film.dart';
import 'package:course_work/viewModel/service/film_service.dart';

class LoadFavoriteFilmsUc {
  final FilmService _filmService;
  LoadFavoriteFilmsUc(this._filmService);
  Future<List<Film>> use() {
    return _filmService.loadStorageFilms();
  }

}