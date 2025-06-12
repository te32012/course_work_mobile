import 'package:course_work/data/model/film.dart';
import 'package:json_annotation/json_annotation.dart';

part 'topFilmRequest.g.dart';


@JsonSerializable(explicitToJson: true)
class TopFilmRequest {
  TopFilmRequest(this.films);
  List<Film> films = [];
  factory TopFilmRequest.fromJson(Map<String, dynamic> json) =>
      _$TopFilmRequestFromJson(json);
  Map<String, dynamic> toJson() => _$TopFilmRequestToJson(this);
}

