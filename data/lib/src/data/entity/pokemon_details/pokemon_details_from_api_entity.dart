import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_details_from_api_entity.freezed.dart';
part 'pokemon_details_from_api_entity.g.dart';

@freezed
class PokemonDetailsFromApiEntity with _$PokemonDetailsFromApiEntity {
  factory PokemonDetailsFromApiEntity({
    required int id,
    required String name,
    required List<Map<String, dynamic>> types,
    required int height,
    required int weight,
  }) = _PokemonDetailsFromApiEntity;

  factory PokemonDetailsFromApiEntity.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailsFromApiEntityFromJson(json);
}
