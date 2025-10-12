

import 'dart:convert';

import 'package:course_work/model/entity/film.dart';
import 'package:sqflite/sqflite.dart';

class DbRepo {
  final Database _db;

  DbRepo(this._db);

  void init() {
  }

  Future<int> insertFilm(Film film) async {
    return _db.insert('films', filmToJsonMap(film));
  }

  Future<int> deleteFilm(int id) async {
    return _db.delete('films', where: 'idFilm=?', whereArgs: [id]);
  }

  Future<List<Film>?> getAll() async {
    return _db.rawQuery('SELECT idFilm, data FROM films').then((v) {
      return v.map((l) => jsonMapToFilm(l)).toList();
    });
  }

  Future<bool> hasElement(int id) async {
    var res = await _db.query("films", where: "idFilm = ?", whereArgs: [id]);
    return res.isNotEmpty;
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
