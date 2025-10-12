

import 'dart:typed_data';

import 'package:course_work/viewModel/service/film_service.dart';

class GetImageUc {
  final FilmService filmService;
  
  GetImageUc(this.filmService);

  Future<Uint8List> use(String path) {
    return filmService.fetchImage(path);
  }

}