import 'package:course_work/model/entity/film.dart';
import 'package:course_work/model/repository/db_repo.dart';

class DbService {

  final DbRepo _dbRepo;

  DbService(this._dbRepo);

  Future<int> insertFilm(Film film) {
    return _dbRepo.insertFilm(film);
  }

  Future<int> deleteFilm(int id) {
   return  _dbRepo.deleteFilm(id);
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

  Future<bool> hasElement(int id) async {
    return _dbRepo.hasElement(id);
  }

}