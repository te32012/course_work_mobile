import 'package:course_work/model/entity/film.dart';
import 'package:course_work/viewModel/cubitAndBloc/state/about_film_state.dart';
import 'package:course_work/viewModel/usecase/about_films_uc.dart';
import 'package:course_work/viewModel/usecase/get_image_uc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutFilmCubit extends Cubit<AboutFilmWithFilmState> {
  AboutFilmCubit(this._aboutFilmsUc, this._getImageUc, {Film? film})
    : super(AboutFilmWithFilmState(Film())) {
    if (film != null) {
      setFilmState(film);
    }
  }

  final AboutFilmsUc _aboutFilmsUc;
  final GetImageUc _getImageUc;

  void setFilmState(Film film) async {
    var f = await _aboutFilmsUc.use(film);
    var u8l = await _getImageUc.use(f.posterUrl);
    f.posterData = u8l;
    emit(AboutFilmWithFilmState(f));
  }
}
