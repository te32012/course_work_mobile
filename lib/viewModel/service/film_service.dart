import 'dart:typed_data';

import 'package:course_work/model/entity/film.dart';
import 'package:course_work/model/repository/films_repo.dart';

class FilmService {
  final FilmsRepo _filmsRepo;

  FilmService(this._filmsRepo);

  Future<String> fetchPage(Map<String, String> headers, String path) async {
    return _filmsRepo.fetchPage(headers, path);
  }

  Future<Uint8List> fetchImage(String path) async {
    return _filmsRepo.fetchImage(path);
  }

  Future<List<Film>> loadStorageFilms() {
    return _filmsRepo.loadStorageFilms();
  }

  Future<int> addFilmToFav(Film film) {
    return _filmsRepo.addFilmToFav(film);
  }

  Future<int> removeFilmFromFav(int id) {
    return _filmsRepo.removeFilmFromFav(id);
  }

  Future<bool> hasElementInStorage(int id) {
    return _filmsRepo.hasElementInStorage(id);
  }
}
