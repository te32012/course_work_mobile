import 'dart:convert';

import 'package:course_work/model/entity/film.dart';
import 'package:course_work/model/entity/film_request.dart';
import 'package:course_work/viewModel/service/film_service.dart';

class AboutFilmsUc {
  final FilmService _filmService;

  AboutFilmsUc(this._filmService);
  Future<Film> use(Film film) async {
    var headers = {"Content-Type": "application/json"};
    final response = _filmService.fetchPage(
      headers,
      'http://kinopoiskapiunofficial.tech/api/v2.2/films/${film.filmId}',
    );
    FilmRequest req = FilmRequest.fromJson(
      jsonDecode(await response) as Map<String, dynamic>,
    );
    return Film(
      filmId: film.filmId,
      nameRu: film.nameRu,
      countries: req.countries != null
          ? req.countries!
          : [Countries("Страны не найдены")],
      genres: req.genres != null ? req.genres! : [Genres("Жанры не найдены")],
      posterUrl: film.posterUrl,
      year: film.year,
      description: req.description ?? "Описание не найдено"
    );
  }
}
