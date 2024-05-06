import 'package:freezed_annotation/freezed_annotation.dart';

part 'poke_list_part_from_db_entity.freezed.dart';
part 'poke_list_part_from_db_entity.g.dart';

@freezed
class PokeListPartFromDbEntity with _$PokeListPartFromDbEntity {
  factory PokeListPartFromDbEntity({
    required String name,
    required int id,
    required String image,
  }) = _PokeListPartFromDbEntity;

  factory PokeListPartFromDbEntity.fromJson(Map<String, dynamic> json) =>
      _$PokeListPartFromDbEntityFromJson(json);
}
