import 'dart:convert';

import 'package:course_work/data/model/film.dart';
import 'package:course_work/data/model/film_request.dart';
import 'package:course_work/data/model/top_film_request.dart';
import 'package:course_work/data/repository/favorite_film_repository.dart';
import 'package:course_work/data/repository/tmp_film_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

final String apiKey = "5e58b82f-6e4e-45f8-8b75-2e5210aadcff";

class Restcontroller extends GetxController {
  Rx<FavoriteFilmRepository> storage;
  Rx<TmpFilmRepository> tmp;
  var isLoading = false;
  var count = 1;

  Restcontroller(this.storage, this.tmp);

  @override
  void onInit() async {
    super.onInit();
    fetchPageTopFilm();
  }
  void buttonPressed(bool e, Film f) async {
    if (e) {
      await storage.value.insertFilm(f);
    } else {
      await storage.value.deleteFilm(f.filmId);
    }
  }

  Future<void> fetchPageTopFilm() async {
    isLoading = true;
    var headers = {"X-API-KEY": apiKey, "Content-Type": "application/json"};
    final response = await http.get(
      Uri.parse(
        'http://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_100_POPULAR_FILMS&page=$count',
      ),
      headers: headers,
    );
    if (response.statusCode == 200) {
      tmp.value.films.addAll(
        TopFilmRequest.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        ).films
      );
      count++;
      isLoading = false;
    } else {
      isLoading = false;
      throw Exception("failed to download top films");
    }
  }

  Future<TopFilmRequest> fetchPageByKeyword(String keyword) async {
    var headers = {"X-API-KEY": apiKey, "Content-Type": "application/json"};
    final response = await http.get(
      Uri.parse(
        'http://kinopoiskapiunofficial.tech//api/v2.2/films?page=$count&keyword=$keyword',
      ),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return TopFilmRequest.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception("failed to download top films");
    }
  }

  Future<FilmRequest> fetchFilmById(int id) async {
    var headers = {"X-API-KEY": apiKey, "Content-Type": "application/json"};
    final response = await http.get(
      Uri.parse('http://kinopoiskapiunofficial.tech/api/v2.2/films/$id'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return FilmRequest.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception("failed to download top films");
    }
  }
}
