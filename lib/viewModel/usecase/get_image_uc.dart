import 'package:course_work/model/entity/film.dart';
import 'package:course_work/viewModel/service/film_service.dart';
import 'package:flutter/services.dart';

class GetImageUc {
  final FilmService _filmService;
  GetImageUc(this._filmService);

  Future<Uint8List?> use(Film film) async {
    return await _filmService.getImage(film);
  }
}
