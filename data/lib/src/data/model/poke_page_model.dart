import 'package:domain/domain.dart' show PokePage;
import 'poke_list_part_model.dart';

class PokePageModel {
  final bool hasNext;
  final List<PokeListPartModel>? pokeList;

  const PokePageModel({required this.hasNext, required this.pokeList});

  factory PokePageModel.fromJson(Map<String, dynamic> json) {
    final bool hasNext = json['next'] != null;
    final List<PokeListPartModel> pokeList = (json['results'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(PokeListPartModel.fromJson)
        .toList();
    return PokePageModel(hasNext: hasNext, pokeList: pokeList);
  }

  PokePage toEntity() {
    return PokePage(
      hasNext: hasNext,
      pokeList: pokeList?.map((PokeListPartModel e) => e.toEntity()).toList(),
    );
  }
}
