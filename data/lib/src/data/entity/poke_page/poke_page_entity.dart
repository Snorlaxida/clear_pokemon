import 'package:freezed_annotation/freezed_annotation.dart';

part 'poke_page_entity.freezed.dart';
part 'poke_page_entity.g.dart';

@freezed
class PokePageEntity with _$PokePageEntity {
  factory PokePageEntity({
    required String? next,
    required List<Map<String, dynamic>>? results,
  }) = _PokePageEntity;

  factory PokePageEntity.fromJson(Map<String, dynamic> json) =>
      _$PokePageEntityFromJson(json);
}
