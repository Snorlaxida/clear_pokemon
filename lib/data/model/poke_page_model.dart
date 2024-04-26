import 'package:clear_pokemon/data/model/poke_list_part_model.dart';
import 'package:clear_pokemon/domain/entity/poke_page.dart';

class PokePageModel {
  final bool hasNext;
  final List<PokeListPartModel>? pokeList;

  const PokePageModel({required this.hasNext, required this.pokeList});

  factory PokePageModel.fromJson(Map<String, dynamic> json) {
    final hasNext = json['next'] != null;
    final pokeList = (json['results'] as List)
        .map((json) => PokeListPartModel.fromJson(json))
        .toList();
    return PokePageModel(hasNext: hasNext, pokeList: pokeList);
  }

  PokePage toEntity() {
    return PokePage(
      hasNext: hasNext,
      pokeList: pokeList?.map((e) => e.toEntity()).toList(),
    );
  }
}
