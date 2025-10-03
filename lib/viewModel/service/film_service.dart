

import 'package:course_work/model/entity/film.dart';
import 'package:course_work/model/repository/films_repo.dart';

class FilmService {
  
  final FilmsRepo _filmsRepo;

  FilmService(this._filmsRepo);

  Future<List<Film>> loadTopFilms() async {
    return _filmsRepo.loadTopFilms();
  }

  Future<List<Film>> loadStorageFilms() {
    return _filmsRepo.loadStorageFilms();
  }

  void addFilmToFav(Film film) {
    _filmsRepo.addFilmToFav(film);
  }

  void removeFilmFromFav(int id) {
    _filmsRepo.removeFilmFromFav(id);
  }

  Future<List<Film>> searchFilm(String keyword) {
    return _filmsRepo.searchFilm(keyword);
  }
  
  void getAdditionalInformationAboutFilm(Film film) {
    return _filmsRepo.getAdditionalInformationAboutFilm(film);
  }

  bool hasElementInStorage(int id) {
    return _filmsRepo.hasElementInStorage(id);
  }


}