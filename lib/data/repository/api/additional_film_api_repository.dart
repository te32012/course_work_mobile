import 'dart:convert';

import 'package:course_work/data/model/film.dart';
import 'package:course_work/data/model/film_request.dart';
import 'package:http/http.dart' as http;

final String apiKey = "5e58b82f-6e4e-45f8-8b75-2e5210aadcff";

class AdditionalApiRepository {
  Future<void> fetchAdditionalAboutFilm(Film f) async {
    var headers = {"X-API-KEY": apiKey, "Content-Type": "application/json"};
    final response = await http.get(
      Uri.parse(
        'http://kinopoiskapiunofficial.tech/api/v2.2/films/${f.filmId}',
      ),
      headers: headers,
    );
    if (response.statusCode == 200) {
      FilmRequest req = FilmRequest.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
      f.description = req.description != null
          ? req.description!
          : "описание не найдено";
      if (f.posterData.isEmpty) {
        getImage(f);
      }
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
