
import 'package:course_work/viewModel/service/film_service.dart';

class HasElementInStorageUc {
  final FilmService _filmService;
  HasElementInStorageUc(this._filmService);
  Future<bool> use(int id) {
    return _filmService.hasElementInStorage(id);
  }
}