import 'dart:convert';
import 'dart:typed_data';

import 'package:course_work/data/model/film.dart';
import 'package:course_work/data/model/film_request.dart';
import 'package:course_work/data/model/films_request.dart';
import 'package:course_work/data/model/top_film_request.dart';
import 'package:course_work/data/repository/favorite_film_repository.dart';
import 'package:course_work/data/repository/tmp_film_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

final String apiKey = "5e58b82f-6e4e-45f8-8b75-2e5210aadcff";

class Restcontroller extends GetxController {
  Rx<FavoriteFilmRepository> storage;
  Rx<TmpFilmRepository> tmp;
  Rx<TmpFilmRepository> search;
  var isLoadingFavorite = false;
  var countFavorite = 1;
  var isLoadingSearch = false;
  var countSearch = 1;
  var lastKeyword = "";
  var isFaivorite = false.obs;

  Restcontroller(this.storage, this.tmp, this.search);

  @override
  void onInit() async {
    super.onInit();
    fetchPageTopFilm();
  }

  void buttonPressed(Film f, bool isFaivorite) async {
    if (isFaivorite) {
      await storage.value.insertFilm(f.obs);
      update();
    } else {
      await storage.value.deleteFilm(f.filmId);
      update();
    }
  }

  Future<void> fetchPageTopFilm() async {
    isLoadingFavorite = true;
    var headers = {"X-API-KEY": apiKey, "Content-Type": "application/json"};
    final response = await http.get(
      Uri.parse(
        'http://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_100_POPULAR_FILMS&page=$countFavorite',
      ),
      headers: headers,
    );
    if (response.statusCode == 200) {
      tmp.value.films.addAll(
        TopFilmRequest.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        ).films.map((toElement) => toElement.obs).map((element) {
          getImage(element).then((_) {
            update();
            element.refresh();
          });
          return element;
        }),
      );
      countFavorite++;
      isLoadingFavorite = false;
    } else {
      isLoadingFavorite = false;
      throw Exception("failed to download top films");
    }
  }

  Future<void> fetchPageByKeyword(String keyword) async {
    if (keyword != lastKeyword) {
      lastKeyword = keyword;
      countSearch = 1;
      search.value.films = <Rx<Film>>[].obs;
    }
    var headers = {"X-API-KEY": apiKey, "Content-Type": "application/json"};
    final response = await http.get(
      Uri.parse(
        'http://kinopoiskapiunofficial.tech//api/v2.2/films?page=$countSearch&keyword=$keyword',
      ),
      headers: headers,
    );
    if (response.statusCode == 200) {
      search.value.films.addAll(
        FilmsRequest.fromJson(jsonDecode(response.body) as Map<String, dynamic>)
            .items
            .map((element) => element.obs)
            .map((element) {
              getImage(element).then((_) {
                update();
                element.refresh();
              });
              return element;
            })
            .map((element) {
              element.refresh();
              return element;
            })
            .toList(),
      );
      countSearch++;
      isLoadingSearch = false;
    } else {
      throw Exception("failed to download top films");
    }
  }

  Future<void> fetchAdditionalAboutFilm(Rx<Film> f) async {
    var headers = {"X-API-KEY": apiKey, "Content-Type": "application/json"};
    final response = await http.get(
      Uri.parse(
        'http://kinopoiskapiunofficial.tech/api/v2.2/films/${f.value.filmId}',
      ),
      headers: headers,
    );
    if (response.statusCode == 200) {
      FilmRequest req = FilmRequest.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
      f.value.description = req.description != null
          ? req.description!
          : "описание не найдено";
      if (f.value.posterData.isEmpty) {
        getImage(f).then((_) {
          update();
          f.refresh();
        });
      }
      f.refresh();
    } else {
      throw Exception("failed to download top films");
    }
  }

  Future<void> getImage(Rx<Film> film) async {
    var headers = {"X-API-KEY": apiKey};
    var resp = await http.get(
      Uri.parse(film.value.posterUrl),
      headers: headers,
    );
    if (resp.statusCode == 200) {
      film.value.posterData = resp.bodyBytes;
      film.refresh();
    }
  }
}
