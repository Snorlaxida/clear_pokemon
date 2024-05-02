import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'pokemon_details_model.g.dart';

@JsonSerializable()
class PokemonDetailsModel {
  final int pokemonId;
  final String imageUrl;
  final String name;
  final List<String> types;
  final int height;
  final int weight;

  PokemonDetailsModel({
    required this.pokemonId,
    required this.imageUrl,
    required this.name,
    required this.types,
    required this.height,
    required this.weight,
  });

  factory PokemonDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonDetailsModelToJson(this);
}
