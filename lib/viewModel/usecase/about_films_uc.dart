

import 'package:course_work/model/entity/film.dart';
import 'package:course_work/viewModel/service/film_service.dart';

class AboutFilmsUc {
  final FilmService _filmService;
  AboutFilmsUc(this._filmService);
  void use(Film film) {
    return _filmService.getAdditionalInformationAboutFilm(film);
  }

}