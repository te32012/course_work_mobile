import 'dart:convert';

import 'package:course_work/model/entity/film.dart';
import 'package:course_work/model/entity/films_request.dart';
import 'package:course_work/viewModel/service/film_service.dart';

class SearchFilmsUc {
  final FilmService _filmService;
  var isLoadingSearch = false;
  var countSearch = 1;
  var lastKeyword = "";

  SearchFilmsUc(this._filmService);
  Future<List<Film>> use(String keyword) async {
    if (keyword != lastKeyword) {
      lastKeyword = keyword;
      countSearch = 1;
    }
    var headers = {"Content-Type": "application/json"};
    final response = _filmService.fetchPage(
      headers,
      'http://kinopoiskapiunofficial.tech//api/v2.2/films?page=$countSearch&keyword=$keyword',
    );
    Iterable<Film> items = FilmsRequest.fromJson(
      jsonDecode(await response) as Map<String, dynamic>,
    ).items;
    countSearch++;
    isLoadingSearch = false;
    return items.toList();
  }
}
