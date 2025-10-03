import 'package:course_work/model/entity/film.dart';

final class PopularState {
  final List<Film> items;

  const PopularState(this.items);

  @override
  void addFilms(List<Film> films) => items.addAll(films);
}
