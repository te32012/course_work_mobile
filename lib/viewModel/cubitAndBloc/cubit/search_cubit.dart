import 'package:bloc/bloc.dart';
import 'package:course_work/model/entity/film.dart';
import 'package:course_work/viewModel/cubitAndBloc/state/search_state.dart';
import 'package:course_work/viewModel/usecase/add_films_to_fav_uc.dart';
import 'package:course_work/viewModel/usecase/get_image_uc.dart';
import 'package:course_work/viewModel/usecase/has_element_in_storage_uc.dart';
import 'package:course_work/viewModel/usecase/remove_films_from_fav_uc.dart';
import 'package:course_work/viewModel/usecase/search_films_uc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(
    this._addFilmsToFavUc,
    this._removeFilmsFromFavUc,
    this._hasElementInStorageUc,
    this._searchFilmsUc,
    this._getImageUc,
  ) : super(SearchState([]));

  final AddFilmsToFavUc _addFilmsToFavUc;
  final RemoveFilmsFromFavUc _removeFilmsFromFavUc;
  final HasElementInStorageUc _hasElementInStorageUc;
  final SearchFilmsUc _searchFilmsUc;
  final GetImageUc _getImageUc;

  Future<void> onTextChanged(String text) async {
    final searchTerm = text;
    if (searchTerm.isEmpty) return emit(SearchState([]));

    final result = await _searchFilmsUc.use(searchTerm);
    for (Film f in result) {
      f.isFaivorite = await _hasElementInStorageUc.use(f.filmId);
      f.posterData = await _getImageUc.use(f.posterUrl);
      emit(SearchState(result));
    }
    emit(SearchState(result));
  }

  void removeFilmFromFav(int id) {
    _removeFilmsFromFavUc.use(id);
    state.items.map((e) {
      var ans = false;
      _hasElementInStorageUc.use(e.filmId).then((val) {
        ans = val;
      });
      e.isFaivorite = ans;
    }).toList();
    emit(SearchState(state.items));
  }

  void addFilmsToFavUc(Film film) {
    _addFilmsToFavUc.use(film);
    state.items.map((e) {
      var ans = false;
      _hasElementInStorageUc.use(e.filmId).then((val) {
        ans = val;
      });
      e.isFaivorite = ans;
    }).toList();
    emit(SearchState(state.items));
  }
  void updateFilmsStatus() async {
    for (Film f in state.items) {
      var ok = await _hasElementInStorageUc.use(f.filmId);
      f.isFaivorite = ok;
    }
    emit(SearchState(state.items));
  }

  Future<bool> hasElementInStorage(int id) async {
    return _hasElementInStorageUc.use(id);
  }
}
