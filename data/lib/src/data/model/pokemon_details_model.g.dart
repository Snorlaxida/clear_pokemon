// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonDetailsModel _$PokemonDetailsModelFromJson(Map<String, dynamic> json) =>
    PokemonDetailsModel(
      pokemonId: (json['id'] as num).toInt(),
      imageUrl: json['sprites']['other']['official-artwork']['front_default']
          as String,
      name: json['name'] as String,
      types: (json['types'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map((Map<String, dynamic> e) => e['type']['name'] as String)
          .toList(),
      height: (json['height'] as num).toInt(),
      weight: (json['weight'] as num).toInt(),
    );

Map<String, dynamic> _$PokemonDetailsModelToJson(
        PokemonDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.pokemonId,
      'image': instance.imageUrl,
      'name': instance.name,
      'types': jsonEncode(instance.types),
      'height': instance.height,
      'weight': instance.weight,
    };
