import 'package:freezed_annotation/freezed_annotation.dart';

part 'poke_list_part_from_api_entity.freezed.dart';
part 'poke_list_part_from_api_entity.g.dart';

@freezed
class PokeListPartFromApiEntity with _$PokeListPartFromApiEntity {
  factory PokeListPartFromApiEntity({
    required String url,
    required String name,
  }) = _PokeListPartFromApiEntity;

  factory PokeListPartFromApiEntity.fromJson(Map<String, dynamic> json) =>
      _$PokeListPartFromApiEntityFromJson(json);
}
