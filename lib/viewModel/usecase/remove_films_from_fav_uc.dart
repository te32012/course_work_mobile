import 'package:course_work/model/entity/film.dart';
import 'package:course_work/viewModel/service/film_service.dart';

class RemoveFilmsFromFavUc {
  final FilmService _filmService;
  RemoveFilmsFromFavUc(this._filmService);
  void use(int id) {
    _filmService.removeFilmFromFav(id);
  }
}
