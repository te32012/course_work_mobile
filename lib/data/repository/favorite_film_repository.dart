import 'package:course_work/data/model/film.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

class WarpFilm {
  final Rx<Film> film;
  WarpFilm(this.film);
}

class FavoriteFilmRepository extends GetxService {
  final Database _db;
  final storageMap = <int, WarpFilm>{}.obs;
  final storageList = <WarpFilm>[].obs;


  FavoriteFilmRepository(this._db);

  void init() {
    getAll().then((onValue) {
      onValue!.map((film) {
        storageMap[film.value.filmId] = WarpFilm(film);
        storageList.add(storageMap[film.value.filmId]!);
      }).toList();
    });
  }

  Future<int> insertFilm(Rx<Film> film) async {
    storageMap[film.value.filmId] = WarpFilm(film);
    storageList.add(storageMap[film.value.filmId]!);
    return _db.insert('films', filmToJsonMap(film.value));
  }

  Future<int> deleteFilm(int id) async {
    if (storageMap.containsKey(id)) {
      storageList.remove(storageMap[id]);
      storageMap.remove(id);
    }
    return _db.delete('films', where: 'idFilm=?', whereArgs: [id]);
  }

  Future<List<Rx<Film>>?> getAll() async {
    return _db.rawQuery('SELECT idFilm, data FROM films').then((v) {
      return v.map((l) => jsonMapToFilm(l)).map((value) => value.obs).toList();
    });
  }

  bool hasElement(int id) {
    return storageMap.containsKey(id);
  }

  Map<String, dynamic> filmToJsonMap(Film film) {
    var m = {'idFilm': film.filmId, 'data': jsonEncode(film.toJson())};
    return m;
  }

  Film jsonMapToFilm(Map<String, Object?> m) {
    return Film.fromJson(
      jsonDecode(m['data'] as String) as Map<String, Object?>,
    );
  }
}
