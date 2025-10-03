// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilmRequest _$FilmRequestFromJson(Map<String, dynamic> json) => FilmRequest()
  ..description = json['description'] as String?
  ..year = (json['year'] as num?)?.toInt()
  ..genres = (json['genres'] as List<dynamic>?)
      ?.map((e) => Genres.fromJson(e as Map<String, dynamic>))
      .toList()
  ..countries = (json['countries'] as List<dynamic>?)
      ?.map((e) => Countries.fromJson(e as Map<String, dynamic>))
      .toList()
  ..posterUrl = json['posterUrl'] as String;

Map<String, dynamic> _$FilmRequestToJson(FilmRequest instance) =>
    <String, dynamic>{
      'description': instance.description,
      'year': instance.year,
      'genres': instance.genres,
      'countries': instance.countries,
      'posterUrl': instance.posterUrl,
    };
