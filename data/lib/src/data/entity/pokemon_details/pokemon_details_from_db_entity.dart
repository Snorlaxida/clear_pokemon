import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_details_from_db_entity.freezed.dart';
part 'pokemon_details_from_db_entity.g.dart';

@freezed
class PokemonDetailsFromDbEntity with _$PokemonDetailsFromDbEntity {
  factory PokemonDetailsFromDbEntity({
    required int id,
    required String name,
    required String image,
    required List<String> types,
    required int height,
    required int weight,
  }) = _PokemonDetailsFromDbEntity;

  factory PokemonDetailsFromDbEntity.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailsFromDbEntityFromJson(json);
}
