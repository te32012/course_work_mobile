import 'package:course_work/model/entity/film.dart';

final class FavoriteState {
  final List<Film> items;

  const FavoriteState(this.items);

  @override
  void addFilms(List<Film> films) => items.addAll(films);
}
