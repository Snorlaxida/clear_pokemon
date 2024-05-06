import 'package:freezed_annotation/freezed_annotation.dart';

part 'poke_page_from_api_entity.freezed.dart';
part 'poke_page_from_api_entity.g.dart';

@freezed
class PokePageFromApiEntity with _$PokePageFromApiEntity {
  factory PokePageFromApiEntity({
    required bool? next,
    required List<Map<String, dynamic>>? results,
  }) = _PokePageFromApiEntity;

  factory PokePageFromApiEntity.fromJson(Map<String, dynamic> json) =>
      _$PokePageFromApiEntityFromJson(json);
}
