import 'package:course_work/model/entity/film.dart';
import 'package:course_work/viewModel/cubitAndBloc/state/about_film_state.dart';
import 'package:course_work/viewModel/usecase/about_films_uc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutFilmCubit extends Cubit<AboutFilmState> {
  AboutFilmCubit(this._aboutFilmsUc) : super(AboutFilmEmptyState());

  final AboutFilmsUc _aboutFilmsUc;

  void setFilmState(Film film) {
    _aboutFilmsUc.use(film);
    emit(AboutFilmWithFilmState(film));
  }
}
