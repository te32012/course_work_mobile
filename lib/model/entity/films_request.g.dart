// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'films_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilmsRequest _$FilmsRequestFromJson(Map<String, dynamic> json) => FilmsRequest()
  ..items = (json['items'] as List<dynamic>)
      .map((e) => Film.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$FilmsRequestToJson(FilmsRequest instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
