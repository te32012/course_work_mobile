import 'package:bloc/bloc.dart';
import 'package:course_work/model/entity/film.dart';
import 'package:course_work/viewModel/cubitAndBloc/state/search_state.dart';
import 'package:course_work/viewModel/usecase/add_films_to_fav_uc.dart';
import 'package:course_work/viewModel/usecase/has_element_in_storage_uc.dart';
import 'package:course_work/viewModel/usecase/remove_films_from_fav_uc.dart';
import 'package:course_work/viewModel/usecase/search_films_uc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(
    this._addFilmsToFavUc,
    this._removeFilmsFromFavUc,
    this._hasElementInStorageUc,
    this._searchFilmsUc,
  ) : super(SearchState([]));

  final AddFilmsToFavUc _addFilmsToFavUc;
  final RemoveFilmsFromFavUc _removeFilmsFromFavUc;
  final HasElementInStorageUc _hasElementInStorageUc;
  final SearchFilmsUc _searchFilmsUc;

  Future<void> onTextChanged(String text) async {
    final searchTerm = text;
    if (searchTerm.isEmpty) return emit(SearchState([]));

    try {
      final result = await _searchFilmsUc.use(searchTerm);
      emit(SearchState(result));
    } catch (error) {
      emit(const SearchState([]));
    }
  }

  void removeFilmFromFav(int id) {
    _removeFilmsFromFavUc.use(id);
    var tmp = state.items;
    var ans = tmp.map((e) {
      var tmp = e;
      tmp.isFaivorite = _hasElementInStorageUc.use(e.filmId);
      return tmp;
    }).toList();
    emit(SearchState(ans));
  }

  void addFilmsToFavUc(Film film) {
    _addFilmsToFavUc.use(film);
    var tmp = state.items;
    var ans = tmp.map((e) {
      var tmp = e;
      tmp.isFaivorite = _hasElementInStorageUc.use(e.filmId);
      return tmp;
    }).toList();
    emit(SearchState(ans));
  }

  bool hasElementInStorage(int id) {
    return _hasElementInStorageUc.use(id);
  }
}
