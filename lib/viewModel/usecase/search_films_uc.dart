import 'package:course_work/model/entity/film.dart';
import 'package:course_work/viewModel/service/film_service.dart';

class SearchFilmsUc {
  final FilmService _filmService;
  SearchFilmsUc(this._filmService);
  Future<List<Film>> use(String keyword) {
    return _filmService.searchFilm(keyword);
  }
}
