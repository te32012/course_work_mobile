import 'package:course_work/model/entity/film.dart';
import 'package:json_annotation/json_annotation.dart';

part 'films_request.g.dart';

@JsonSerializable()
class FilmsRequest {
  List<Film> items = [];
  FilmsRequest();
  factory FilmsRequest.fromJson(Map<String, dynamic> json) =>
      _$FilmsRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FilmsRequestToJson(this);

}