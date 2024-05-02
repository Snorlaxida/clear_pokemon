// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poke_list_part_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokeListPartModel _$PokeListPartModelFromJson(Map<String, dynamic> json) =>
    PokeListPartModel(
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${json['url'].toString().split('/')[6]}.png',
      name: (json['name'] as String),
      id: int.parse(json['url'].toString().split('/')[6]),
    );

Map<String, dynamic> _$PokeListPartModelToJson(PokeListPartModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'imageUrl': instance.imageUrl,
    };
