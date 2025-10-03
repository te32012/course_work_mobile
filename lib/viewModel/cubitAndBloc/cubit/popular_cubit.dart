import 'package:bloc/bloc.dart';
import 'package:course_work/model/entity/film.dart';
import 'package:course_work/viewModel/cubitAndBloc/state/popular_state.dart';
import 'package:course_work/viewModel/usecase/add_films_to_fav_uc.dart';
import 'package:course_work/viewModel/usecase/has_element_in_storage_uc.dart';
import 'package:course_work/viewModel/usecase/load_top_films_uc.dart';
import 'package:course_work/viewModel/usecase/remove_films_from_fav_uc.dart';



class PopularCubit extends Cubit<PopularState> {

  PopularCubit(this._addFilmsToFavUc, this._removeFilmsFromFavUc, this._hasElementInStorageUc, this._loadTopFilmsUc) : super(PopularState([]));

  final AddFilmsToFavUc _addFilmsToFavUc;
  final RemoveFilmsFromFavUc _removeFilmsFromFavUc;
  final HasElementInStorageUc _hasElementInStorageUc;
  final LoadTopFilmsUc _loadTopFilmsUc;


  // подгружает популярные фильмы при первом запуске
  void init() async {
    var ans = await _loadTopFilmsUc.use();
    var tmp = ans.map((e) {
      var tmp = e;
      tmp.isFaivorite = _hasElementInStorageUc.use(e.filmId);
      return tmp;
    }).toList();
    emit(PopularState(tmp));
  }

  // подгружает популярные фильмы при скроллинге ленты
  void nextFilm() async {
    var ans = await _loadTopFilmsUc.use();
    var items = state.items;
    ans.addAll(items);
    var tmp = ans.map((e) {
      var tmp = e;
      tmp.isFaivorite = _hasElementInStorageUc.use(e.filmId);
      return tmp;
    }).toList();
    emit(PopularState(tmp));
  }

  void removeFilmFromFav(int id) {
    _removeFilmsFromFavUc.use(id);
    var tmp = state.items;
    var ans = tmp.map((e) {
      var tmp = e;
      tmp.isFaivorite = _hasElementInStorageUc.use(e.filmId);
      return tmp;
    }).toList();
    emit(PopularState(ans));
  }

  void addFilmsToFavUc(Film film) {
    _addFilmsToFavUc.use(film);
    var tmp = state.items;
    var ans = tmp.map((e) {
      var tmp = e;
      tmp.isFaivorite = _hasElementInStorageUc.use(e.filmId);
      return tmp;
    }).toList();
    emit(PopularState(ans));
  }

  bool hasElementInStorage(int id) {
    return _hasElementInStorageUc.use(id);
  }
}