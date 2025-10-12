import 'dart:typed_data';

import 'package:course_work/model/entity/film.dart';
import 'package:course_work/model/repository/http_repo.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final HttpRepo _HttpRepo;

  const HttpService(this._HttpRepo);

  Future<String> fetchPage(Map<String, String> headers, String path) async {
    return _HttpRepo.fetchPage(headers, path);
  }

  Future<Uint8List> fetchImage(String path) async {
    return _HttpRepo.fetchImage(path);
  }
}
