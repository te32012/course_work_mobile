import 'dart:convert';
import 'dart:typed_data';

import 'package:course_work/model/entity/film.dart';
import 'package:course_work/model/entity/film_request.dart';
import 'package:course_work/model/entity/films_request.dart';
import 'package:course_work/model/entity/top_film_request.dart';
import 'package:http/http.dart' as http;

final String apiKey = "5e58b82f-6e4e-45f8-8b75-2e5210aadcff";

class HttpRepo {
  // var isLoadingFavorite = false;
  // var countFavorite = 1;
  const HttpRepo();

  Future<String> fetchPage(Map<String, String> headers, String path) async {
    headers["X-API-KEY"] = apiKey;
    final response = await http.get(Uri.parse(path), headers: headers);
    return response.body;
  }

  Future<Uint8List> fetchImage(String path) async {
    var headers = {"X-API-KEY": apiKey};
    var resp = await http.get(Uri.parse(path), headers: headers);
    return resp.bodyBytes;
  }

}
