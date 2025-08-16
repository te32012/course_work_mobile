import 'package:bloc/bloc.dart';
import 'package:course_work/data/model/film.dart';
import 'package:course_work/data/repository/api/lenta_api_repository.dart';
import 'package:course_work/data/repository/storage/favorite_film_repository.dart';
import 'package:course_work/state/lenta_state.dart';



class LentaCubit extends Cubit<LentaState> {

  LentaCubit(this._lentaApiRepository) : super(LentaEmptyState(false));

  final LentaApiRepository _lentaApiRepository;

  void init(FavoriteFilmRepository favoriteFilmRepository) async {
    final result = await _lentaApiRepository.fetchPageTopFilm();
    if(result.isEmpty) {
      emit(LentaEmptyState(state.isFaivorite));
    } else {
      emit(LentaWithFilmsState(state.isFaivorite, result, favoriteFilmRepository));
    }
  }

  void nextFilm() async {
    final result = await _lentaApiRepository.fetchPageTopFilm();
    addFilms(result);
  }


  void addFilms(List<Film> films) {
    if (films.isEmpty && state is LentaEmptyState) {
      LentaEmptyState newState = LentaEmptyState(state.isFaivorite);
      emit(newState);
    } else if (state is LentaWithFilmsState) {
      LentaWithFilmsState currentState = state as LentaWithFilmsState;
      LentaWithFilmsState newState = LentaWithFilmsState(state.isFaivorite, [], currentState.favoriteFilmRepository);
      newState.addFilms(currentState.items);
      newState.addFilms(films);
      emit(newState);
    }
  }

  void changeFaivoriteSataus(bool status) {
    if (state is LentaEmptyState) {
      emit(LentaEmptyState(status));
    } else if (state is LentaWithFilmsState) {
      var currState = state as LentaWithFilmsState;
      emit(LentaWithFilmsState(status, currState.items, currState.favoriteFilmRepository));
    }
  }
}