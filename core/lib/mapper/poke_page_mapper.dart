import 'package:data/data.dart' show PokePageModel;
import 'package:domain/domain.dart' show PokePage;

import 'poke_list_part_from_api_mapper.dart';

class PokePageMapper {
  static PokePage toEntity(PokePageModel pokePage) {
    return PokePage(
      hasNext: pokePage.hasNext,
      pokeList: pokePage.pokeList?.map(PokeListPartMapper.toEntity).toList(),
    );
  }
}
