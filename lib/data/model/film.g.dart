// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Countries _$CountriesFromJson(Map<String, dynamic> json) =>
    Countries(json['country'] as String);

Map<String, dynamic> _$CountriesToJson(Countries instance) => <String, dynamic>{
  'country': instance.country,
};

Genres _$GenresFromJson(Map<String, dynamic> json) =>
    Genres(json['genre'] as String);

Map<String, dynamic> _$GenresToJson(Genres instance) => <String, dynamic>{
  'genre': instance.genre,
};

Film _$FilmFromJson(Map<String, dynamic> json) => Film(
  (json['filmId'] as num).toInt(),
  json['nameRu'] as String,
  (json['countries'] as List<dynamic>)
      .map((e) => Countries.fromJson(e as Map<String, dynamic>))
      .toList(),
  (json['genres'] as List<dynamic>)
      .map((e) => Genres.fromJson(e as Map<String, dynamic>))
      .toList(),
  json['posterUrl'] as String,
)..year = json['year'] as String;

Map<String, dynamic> _$FilmToJson(Film instance) => <String, dynamic>{
  'filmId': instance.filmId,
  'nameRu': instance.nameRu,
  'countries': instance.countries.map((e) => e.toJson()).toList(),
  'genres': instance.genres.map((e) => e.toJson()).toList(),
  'year': instance.year,
  'posterUrl': instance.posterUrl,
};
