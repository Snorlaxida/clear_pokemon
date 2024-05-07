import 'package:freezed_annotation/freezed_annotation.dart';

part 'poke_list_part_entity.freezed.dart';
part 'poke_list_part_entity.g.dart';

@freezed
class PokeListPartEntity with _$PokeListPartEntity {
  factory PokeListPartEntity({
    required String url,
    required String name,
  }) = _PokeListPartEntity;

  factory PokeListPartEntity.fromJson(Map<String, dynamic> json) =>
      _$PokeListPartEntityFromJson(json);
}
