import 'package:json_annotation/json_annotation.dart';

part 'film.g.dart';

@JsonSerializable()
class Countries {
  Countries(this.country);
  String country = "";
  factory Countries.fromJson(Map<String, dynamic> json) =>
      _$CountriesFromJson(json);
  Map<String, dynamic> toJson() => _$CountriesToJson(this);
}
@JsonSerializable()
class Genres {
  Genres(this.genre);
  String genre = "";
  factory Genres.fromJson(Map<String, dynamic> json) =>
      _$GenresFromJson(json);
  Map<String, dynamic> toJson() => _$GenresToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Film {
  Film(this.filmId, this.nameRu, this.countries, this.genres, this.posterUrl);
  int filmId = -1;
  String nameRu = "";
  List<Countries> countries = [];
  List<Genres> genres = [];
  String year = "";
  String posterUrl = "";
  factory Film.fromJson(Map<String, dynamic> json) =>
      _$FilmFromJson(json);
  Map<String, dynamic> toJson() => _$FilmToJson(this);
}

