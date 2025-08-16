import 'dart:convert';

import 'package:course_work/data/model/film.dart';
import 'package:course_work/data/model/films_request.dart';
import 'package:http/http.dart' as http;

final String apiKey = "5e58b82f-6e4e-45f8-8b75-2e5210aadcff";

class SearchApiRepository {
  var isLoadingSearch = false;
  var countSearch = 1;
  var lastKeyword = "";

  Future<List<Film>> fetchPageByKeyword(String keyword) async {
    if (keyword != lastKeyword) {
      lastKeyword = keyword;
      countSearch = 1;
    }
    var headers = {"X-API-KEY": apiKey, "Content-Type": "application/json"};
    final response = await http.get(
      Uri.parse(
        'http://kinopoiskapiunofficial.tech//api/v2.2/films?page=$countSearch&keyword=$keyword',
      ),
      headers: headers,
    );
    if (response.statusCode == 200) {
      List<Film> items = FilmsRequest.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      ).items.map((element) {
        getImage(element);
        return element;
      }).toList();
      countSearch++;
      isLoadingSearch = false;
      return items;
    } else {
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
