import 'package:bloc/bloc.dart';
import 'package:course_work/model/entity/film.dart';
import 'package:course_work/viewModel/cubitAndBloc/state/popular_state.dart';
import 'package:course_work/viewModel/usecase/add_films_to_fav_uc.dart';
import 'package:course_work/viewModel/usecase/get_image_uc.dart';
import 'package:course_work/viewModel/usecase/has_element_in_storage_uc.dart';
import 'package:course_work/viewModel/usecase/load_top_films_uc.dart';
import 'package:course_work/viewModel/usecase/remove_films_from_fav_uc.dart';

class PopularCubit extends Cubit<PopularState> {
  PopularCubit(
    this._addFilmsToFavUc,
    this._removeFilmsFromFavUc,
    this._hasElementInStorageUc,
    this._loadTopFilmsUc,
    this._getImageUc,
  ) : super(PopularState([]));

  final AddFilmsToFavUc _addFilmsToFavUc;
  final RemoveFilmsFromFavUc _removeFilmsFromFavUc;
  final HasElementInStorageUc _hasElementInStorageUc;
  final LoadTopFilmsUc _loadTopFilmsUc;
  final GetImageUc _getImageUc;

  // подгружает популярные фильмы при первом запуске
  void init() async {
    var ans = await _loadTopFilmsUc.use();
    for (Film f in ans) {
      f.posterData = await _getImageUc.use(f.posterUrl);
      f.isFaivorite = await _hasElementInStorageUc.use(f.filmId);
      emit(PopularState(ans));
    }
    emit(PopularState(ans));
  }

  // подгружает популярные фильмы при скроллинге ленты
  void nextFilm() async {
    var ans = await _loadTopFilmsUc.use();
    state.items.addAll(ans);
    for (Film f in ans) {
      f.posterData = await _getImageUc.use(f.posterUrl);
      f.isFaivorite = await _hasElementInStorageUc.use(f.filmId);
      emit(PopularState(state.items));
    }
    emit(PopularState(state.items));
  }

  void removeFilmFromFav(int id) async {
    await _removeFilmsFromFavUc.use(id);
    var tmp = state.items.map((e) {
      _hasElementInStorageUc.use(e.filmId).then((val) {
        e.isFaivorite = val;
      });
      return e;
    }).toList();
    emit(PopularState(tmp));
  }

  void addFilmsToFavUc(Film film) async {
    await _addFilmsToFavUc.use(film);
    var tmp = state.items.map((e) {
      _hasElementInStorageUc.use(e.filmId).then((val) {
        e.isFaivorite = val;
      });
      return e;
    }).toList();
    emit(PopularState(tmp));
  }

  void updateFilmsStatus() async {
    for (Film f in state.items) {
      var ok = await _hasElementInStorageUc.use(f.filmId);
      f.isFaivorite = ok;
    }
    emit(PopularState(state.items));
  }

  Future<bool> hasElementInStorage(int id) async {
    return _hasElementInStorageUc.use(id);
  }
}
