import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_details_entity.freezed.dart';
part 'pokemon_details_entity.g.dart';

@freezed
class PokemonDetailsEntity with _$PokemonDetailsEntity {
  factory PokemonDetailsEntity({
    required int id,
    required String name,
    required List<Map<String, dynamic>> types,
    required int height,
    required int weight,
  }) = _PokemonDetailsEntity;

  factory PokemonDetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailsEntityFromJson(json);
}
