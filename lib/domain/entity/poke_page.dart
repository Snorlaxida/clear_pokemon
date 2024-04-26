import 'package:clear_pokemon/domain/entity/poke_list_part.dart';

class PokePage {
  final bool hasNext;
  final List<PokeListPart>? pokeList;

  const PokePage({required this.hasNext, required this.pokeList});
}
