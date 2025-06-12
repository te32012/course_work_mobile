// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topFilmRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopFilmRequest _$TopFilmRequestFromJson(Map<String, dynamic> json) =>
    TopFilmRequest(
      (json['films'] as List<dynamic>)
          .map((e) => Film.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopFilmRequestToJson(TopFilmRequest instance) =>
    <String, dynamic>{'films': instance.films.map((e) => e.toJson()).toList()};
