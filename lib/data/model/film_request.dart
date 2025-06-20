import 'package:course_work/data/model/film.dart';
import 'package:json_annotation/json_annotation.dart';

part 'film_request.g.dart';

@JsonSerializable()
class FilmRequest {
  String? description = "";
  int? year = -1;
  List<Genres>? genres = [];
  List<Countries>? countries = [];
  String? posterUrl = "";
  FilmRequest();

  factory FilmRequest.fromJson(Map<String, dynamic> json) =>
      _$FilmRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FilmRequestToJson(this);
}