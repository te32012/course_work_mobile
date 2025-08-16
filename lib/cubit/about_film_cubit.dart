

import 'package:course_work/data/model/film.dart';
import 'package:course_work/data/repository/api/additional_film_api_repository.dart';
import 'package:course_work/state/about_film_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutFilmCubit extends Cubit<AboutFilmState> {
  
  AboutFilmCubit(this._additionalApiRepository) : super(AboutFilmEmptyState());

  final AdditionalApiRepository _additionalApiRepository;

  void setFilmState(Film film) {
    _additionalApiRepository.fetchAdditionalAboutFilm(film);
    emit(AboutFilmWithFilmState(film));
  }
}