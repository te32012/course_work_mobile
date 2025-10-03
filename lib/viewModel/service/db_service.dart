import 'package:course_work/model/entity/film.dart';
import 'package:course_work/model/repository/db_repo.dart';

class DbService {

  final DbRepo _dbRepo;

  DbService(this._dbRepo);

  void insertFilm(Film film) {
    _dbRepo.insertFilm(film);
  }

  void deleteFilm(int id) {
    _dbRepo.deleteFilm(id);
  }

  Future<List<Film>> getAll() async {
    return _dbRepo.getAll().asStream().map((e) {
      if (e is List<Film>) {
        return e;
      } else {
        List<Film> myList = [];
        return myList;
      }
    }).first;
  }

  bool hasElement(int id) {
    return _dbRepo.hasElement(id);
  }

}