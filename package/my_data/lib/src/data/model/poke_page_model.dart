import 'package:my_data/src/data/model/poke_list_part_model.dart';
import 'package:my_domain/my_domain.dart' show PokePage;

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
