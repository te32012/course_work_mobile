import 'dart:typed_data';

class Countries {
  Countries(this.country);
  String country = "";
  factory Countries.fromJson(Map<String, dynamic> json) =>
      _$CountriesFromJson(json);
  Map<String, dynamic> toJson() => _$CountriesToJson(this);
  static Countries _$CountriesFromJson(Map<String, dynamic> json) =>
      Countries(json['country'] as String? ?? '');

  static Map<String, dynamic> _$CountriesToJson(Countries instance) =>
      <String, dynamic>{'country': instance.country};
}

class Genres {
  Genres(this.genre);
  String genre = "";
  factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json);
  Map<String, dynamic> toJson() => _$GenresToJson(this);
  static Genres _$GenresFromJson(Map<String, dynamic> json) =>
      Genres(json['genre'] as String? ?? '');

  static Map<String, dynamic> _$GenresToJson(Genres instance) =>
      <String, dynamic>{'genre': instance.genre};
}

class Film {
  Film({
    this.filmId = -1,
    this.nameRu = "",
    this.countries = const [],
    this.genres = const [],
    this.posterUrl = "",
    this.year = "-1",
  });

  int filmId = -1;
  String nameRu = "";
  List<Countries> countries = [];
  List<Genres> genres = [];
  String year = '';
  String posterUrl = '';
  String description = '';
  Uint8List posterData = Uint8List(0);

  factory Film.fromJson(Map<String, dynamic> json) => _filmFromJson(json);
  Map<String, dynamic> toJson() => _toJson(this);

  @override
  bool operator ==(Object other) =>
      other is Film &&
      other.filmId == filmId &&
      nameRu == other.nameRu &&
      countries == other.countries &&
      genres == other.genres &&
      year == other.year &&
      posterUrl == other.posterUrl &&
      description == other.description &&
      posterData == other.posterData;

  @override
  int get hashCode =>
      (filmId +
          31 * nameRu.hashCode +
          31 * 31 * countries.hashCode +
          31 * 31 * 31 * genres.hashCode +
          31 * 31 * 31 * 31 * year.hashCode +
          31 * 31 * 31 * 31 * 31 * posterUrl.hashCode +
          31 * 31 * 31 * 31 * 31 * 31 * description.hashCode +
          31 * 31 * 31 * 31 * 31 * 31 * 31 * posterData.hashCode) %
      (1_000_000_000 + 7);

  static Film _filmFromJson(Map<String, dynamic> jsonMap) {
    Film current = Film();
    current.posterUrl = jsonMap['posterUrl'] as String? ?? '';
    current.filmId =
        (jsonMap['filmId'] as num?)?.toInt() ??
        ((jsonMap['kinopoiskId'] as num?)?.toInt() ?? -1);
    current.nameRu = jsonMap['nameRu'] as String? ?? '';
    current.description = jsonMap['description'] as String? ?? '';
    current.countries =
        (jsonMap['countries'] as List<dynamic>?)?.map((element) {
          return Countries.fromJson(element as Map<String, dynamic>);
        }).toList() ??
        [];
    current.genres =
        (jsonMap['genres'] as List<dynamic>?)?.map((element) {
          return Genres.fromJson(element as Map<String, dynamic>);
        }).toList() ??
        [];
    dynamic year = jsonMap['year'];
    if (year is String) {
      current.year = year;
    } else if (year is num) {
      current.year = year.toString();
    }
    var list =
        (jsonMap["posterData"] as List<dynamic>?)
            ?.map((element) => (element as num).toInt())
            .toList() ??
        [];
    current.posterData = Uint8List.fromList(list);
    return current;
  }

  static Map<String, dynamic> _toJson(Film film) {
    return <String, dynamic>{
      'posterUrl': film.posterUrl,
      'nameRu': film.nameRu,
      'filmId': film.filmId,
      'description': film.description,
      'genres': film.genres.map((elemenet) => elemenet.toJson()).toList(),
      'countries': film.genres.map((element) => element.toJson()).toList(),
      'year': film.year,
      'posterData': film.posterData.toList(),
    };
  }
}
