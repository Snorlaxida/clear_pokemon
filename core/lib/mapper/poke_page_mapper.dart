import 'package:data/data.dart' show PokeListPartModel, PokePageModel;
import 'package:domain/domain.dart' show PokePage;

import 'poke_list_part_mapper.dart';

class PokePageMapper {
  PokeListPartMapper pokeListPartMapper = PokeListPartMapper();

  PokePage toEntity(PokePageModel pokePage) {
    return PokePage(
      hasNext: pokePage.hasNext,
      pokeList: pokePage.pokeList
          ?.map((PokeListPartModel e) => pokeListPartMapper.toEntity(e))
          .toList(),
    );
  }
}
