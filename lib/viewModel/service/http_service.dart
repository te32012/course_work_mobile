import 'package:course_work/model/entity/film.dart';
import 'package:course_work/model/repository/http_repo.dart';
import 'package:flutter/services.dart';

class HttpService {
  final HttpRepo _HttpRepo;

  HttpService(this._HttpRepo);

  void fetchAdditionalAboutFilm(Film f) {
    _HttpRepo.fetchAdditionalAboutFilm(f);
  }

  Future<List<Film>> fetchPageTopFilm() {
    return _HttpRepo.fetchPageTopFilm();
  }

  Future<List<Film>> fetchPageByKeyword(String keyword) {
    return _HttpRepo.fetchPageByKeyword(keyword);
  }

  Future<Uint8List?> getImage(Film film) async {
    return _HttpRepo.getImage(film);
  }
}
