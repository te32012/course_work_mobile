import 'dart:convert';

import 'package:course_work/data/model/film.dart';
import 'package:course_work/data/model/top_film_request.dart';
import 'package:http/http.dart' as http;

final String apiKey = "5e58b82f-6e4e-45f8-8b75-2e5210aadcff";

class LentaApiRepository {
  var isLoadingFavorite = false;
  var countFavorite = 1;

  LentaApiRepository();

  void onInit() async {
    fetchPageTopFilm();
  }

  /*
    void buttonPressed(Film f, bool isFaivorite) async {
      if (isFaivorite) {
        await storage.value.insertFilm(f.obs);
        update();
      } else {
        await storage.value.deleteFilm(f.filmId);
        update();
      }
    }
  */
  Future<List<Film>> fetchPageTopFilm() async {
    isLoadingFavorite = true;
    var headers = {"X-API-KEY": apiKey, "Content-Type": "application/json"};
    final response = await http.get(
      Uri.parse(
        'http://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_100_POPULAR_FILMS&page=$countFavorite',
      ),
      headers: headers,
    );
    if (response.statusCode == 200) {
      Iterable<Film> films =
          TopFilmRequest.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>,
          ).films.map((element) {
            getImage(element);
            return element;
          });
      countFavorite++;
      isLoadingFavorite = false;
      return films.toList();
    } else {
      isLoadingFavorite = false;
      throw Exception("failed to download top films");
    }
  }

  Future<void> getImage(Film film) async {
    var headers = {"X-API-KEY": apiKey};
    var resp = await http.get(Uri.parse(film.posterUrl), headers: headers);
    if (resp.statusCode == 200) {
      film.posterData = resp.bodyBytes;
    }
  }
}
