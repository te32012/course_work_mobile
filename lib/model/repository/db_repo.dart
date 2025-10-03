

import 'dart:convert';

import 'package:course_work/model/entity/film.dart';
import 'package:sqflite/sqflite.dart';
class WarpFilm {
  final Film film;
  WarpFilm(this.film);
}

class DbRepo {
  final Database _db;
  final storageMap = <int, WarpFilm>{};
  final storageList = <WarpFilm>[];


  DbRepo(this._db);

  void init() {
    getAll().then((onValue) {
      onValue!.map((film) {
        storageMap[film.filmId] = WarpFilm(film);
        storageList.add(storageMap[film.filmId]!);
      }).toList();
    });
  }

  Future<int> insertFilm(Film film) async {
    storageMap[film.filmId] = WarpFilm(film);
    storageList.add(storageMap[film.filmId]!);
    return _db.insert('films', filmToJsonMap(film));
  }

  Future<int> deleteFilm(int id) async {
    if (storageMap.containsKey(id)) {
      storageList.remove(storageMap[id]);
      storageMap.remove(id);
    }
    return _db.delete('films', where: 'idFilm=?', whereArgs: [id]);
  }

  Future<List<Film>?> getAll() async {
    return _db.rawQuery('SELECT idFilm, data FROM films').then((v) {
      return v.map((l) => jsonMapToFilm(l)).toList();
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
