import 'package:course_work/model/entity/film.dart';
import 'package:course_work/viewModel/service/film_service.dart';

class AddFilmsToFavUc {
  final FilmService _filmService;
  AddFilmsToFavUc(this._filmService);
  void use(Film film) {
    _filmService.addFilmToFav(film);
  }
}
