// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poke_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokePageModel _$PokePageModelFromJson(Map<String, dynamic> json) =>
    PokePageModel(
        hasNext: json['next'] != null,
        pokeList: (json['results'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(PokeListPartModel.fromJson)
            .toList());

Map<String, dynamic> _$PokePageModelToJson(PokePageModel instance) =>
    <String, dynamic>{
      'hasNext': instance.hasNext,
      'pokeList': instance.pokeList,
    };
