import 'package:course_work/model/entity/film.dart';
import 'package:course_work/viewModel/cubitAndBloc/state/favorite_state.dart';
import 'package:course_work/viewModel/usecase/add_films_to_fav_uc.dart';
import 'package:course_work/viewModel/usecase/get_image_uc.dart';
import 'package:course_work/viewModel/usecase/has_element_in_storage_uc.dart';
import 'package:course_work/viewModel/usecase/load_favorite_films_uc.dart';
import 'package:course_work/viewModel/usecase/remove_films_from_fav_uc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(
    this._addFilmsToFavUc,
    this._removeFilmsFromFavUc,
    this._hasElementInStorageUc,
    this._loadFavoriteFilmsUc,
    this._getImageUc,
  ) : super(FavoriteState([]));

  final AddFilmsToFavUc _addFilmsToFavUc;
  final RemoveFilmsFromFavUc _removeFilmsFromFavUc;
  final HasElementInStorageUc _hasElementInStorageUc;
  final LoadFavoriteFilmsUc _loadFavoriteFilmsUc;
  final GetImageUc _getImageUc;

  // подгружает популярные фильмы при первом запуске
  void init() async {
    var ans = await _loadFavoriteFilmsUc.use();
    for (Film f in ans) {
      f.posterData = await _getImageUc.use(f.posterUrl);
      f.isFaivorite = await _hasElementInStorageUc.use(f.filmId);
      emit(FavoriteState(ans));
    }
    emit(FavoriteState(ans));
  }

  // подгружает популярные фильмы при скроллинге ленты
  void nextFilm() async {
    var ans = await _loadFavoriteFilmsUc.use();
    for (Film f in ans) {
      f.posterData = await _getImageUc.use(f.posterUrl);
      f.isFaivorite = await _hasElementInStorageUc.use(f.filmId);
      emit(FavoriteState(ans));
    }
    emit(FavoriteState(ans));
  }

  void removeFilmFromFav(int id) async {
    await _removeFilmsFromFavUc.use(id);
    var tmp = <Film>[];
    for (Film f in state.items) {
      var ok = await _hasElementInStorageUc.use(f.filmId);
      if (ok) {
        tmp.add(f);
      }
    }
    emit(FavoriteState(tmp));
  }

  void addFilmsToFavUc(Film film) async {
    await _addFilmsToFavUc.use(film);
    var tmp = <Film>[];
    for (Film f in state.items) {
      var ok = await _hasElementInStorageUc.use(f.filmId);
      if (ok) {
        tmp.add(f);
      }
    }
    emit(FavoriteState(tmp));
  }
  void updateFilmsStatus() async {
    for (Film f in state.items) {
      var ok = await _hasElementInStorageUc.use(f.filmId);
      f.isFaivorite = ok;
    }
    emit(FavoriteState(state.items));
  }

  Future<bool> hasElementInStorage(int id) async {
    return _hasElementInStorageUc.use(id);
  }
}
