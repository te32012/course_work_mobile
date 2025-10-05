import 'dart:convert';
import 'dart:typed_data';

import 'package:course_work/model/entity/film.dart';
import 'package:course_work/viewModel/service/db_service.dart';
import 'package:course_work/viewModel/service/http_service.dart';

class FilmsRepo {
  final HttpService _httpService;
  final DbService _dbService;

  FilmsRepo(this._dbService, this._httpService);

  Future<List<Film>> loadTopFilms() async {
    return _httpService.fetchPageTopFilm();
  }

  Future<List<Film>> loadStorageFilms() {
    return _dbService.getAll();
  }

  void addFilmToFav(Film film) {
    _dbService.insertFilm(film);
  }

  void removeFilmFromFav(int id) {
    _dbService.deleteFilm(id);
  }

  Future<List<Film>> searchFilm(String keyword) {
    return _httpService.fetchPageByKeyword(keyword);
  }

  void getAdditionalInformationAboutFilm(Film film) {
    return _httpService.fetchAdditionalAboutFilm(film);
  }

  bool hasElementInStorage(int id) {
    return _dbService.hasElement(id);
  }

  Future<Uint8List?> getImage(Film film) async =>
      await _httpService.getImage(film);
}
