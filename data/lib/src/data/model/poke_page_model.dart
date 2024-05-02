import 'package:freezed_annotation/freezed_annotation.dart';
import 'poke_list_part_model.dart';

part 'poke_page_model.g.dart';

@JsonSerializable()
class PokePageModel {
  final bool hasNext;
  final List<PokeListPartModel>? pokeList;

  const PokePageModel({required this.hasNext, required this.pokeList});

  factory PokePageModel.fromJson(Map<String, dynamic> json) =>
      _$PokePageModelFromJson(json);
}
