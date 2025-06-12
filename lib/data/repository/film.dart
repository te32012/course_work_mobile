import 'dart:convert';

import 'package:course_work/data/model/film.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class FilmRepository extends GetxService {
  final Database _db;

  FilmRepository(this._db);

  Future<int> insertFilm(Film film) async {
    var tmp = toSqlMap(film);
    return await _db.rawInsert(
      'INSERT INTO films(filmId, data) values (${tmp['filmId']}, ${tmp['data']})',
    );
  }

  Future<int> deleteFilm(int filmId) async {
    return await _db.rawDelete('DELETE FROM films where filmId=$filmId');
  }

  Future<List<Film>> getAll() async {
    List<Map<String, dynamic>> tmp = await _db.rawQuery(
      'SELECT filmId, data FROM films',
    );

    // Use parentheses instead of curly braces to return the list directly.
    return tmp
        .map((value) => Film.fromJson(jsonDecode(value['data'])))
        .toList();
  }
}

Map<String, dynamic> toSqlMap(Film film) {
  var map = <String, dynamic>{
    'filmId': film.filmId,
    'data': jsonEncode(film.toJson()),
  };
  return map;
}
