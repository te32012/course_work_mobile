

import 'dart:convert';
import 'dart:typed_data';

import 'package:course_work/model/entity/film.dart';
import 'package:course_work/viewModel/service/db_service.dart';
import 'package:course_work/viewModel/service/http_service.dart';


class FilmsRepo {
  final HttpService _httpService;
  final DbService _dbService;

  FilmsRepo(this._dbService, this._httpService);

  Future<String> fetchPage(Map<String, String> headers, String path) async {
    return _httpService.fetchPage(headers, path);
  }

  Future<Uint8List> fetchImage(String path) async {
    return _httpService.fetchImage(path);
  }


  Future<List<Film>> loadStorageFilms() {
    return _dbService.getAll();
  }

  Future<int> addFilmToFav(Film film) {
    return _dbService.insertFilm(film);
  }

  Future<int>  removeFilmFromFav(int id) {
    return _dbService.deleteFilm(id);
  }
  
  Future<bool> hasElementInStorage(int id) {
    return _dbService.hasElement(id);
  }
}