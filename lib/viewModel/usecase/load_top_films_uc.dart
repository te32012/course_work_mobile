import 'dart:convert';

import 'package:course_work/model/entity/film.dart';
import 'package:course_work/model/entity/top_film_request.dart';
import 'package:course_work/viewModel/service/film_service.dart';

class LoadTopFilmsUc {
  final FilmService _filmService;
  var isLoadingFavorite = false;
  var countFavorite = 1;

  LoadTopFilmsUc(this._filmService);
  Future<List<Film>> use() async {
    isLoadingFavorite = true;
    var headers = {"Content-Type": "application/json"};
    final response = _filmService.fetchPage(
      headers,
      'http://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_100_POPULAR_FILMS&page=$countFavorite',
    );
    Iterable<Film> films = TopFilmRequest.fromJson(
      jsonDecode(await response) as Map<String, dynamic>,
    ).films;
    countFavorite++;
    isLoadingFavorite = false;
    return films.toList();
  }
}
