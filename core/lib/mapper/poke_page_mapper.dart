import 'package:data/data.dart' show PokeListPartEntity, PokePageEntity;
import 'package:domain/domain.dart' show PokePage;

import 'poke_list_part_mapper.dart';

class PokePageMapper {
  static PokePage fromEntity(PokePageEntity pokePageEntity) {
    return PokePage(
      hasNext: pokePageEntity.next != null,
      pokeList: pokePageEntity.results
          ?.map(
            (Map<String, dynamic> e) =>
                PokeListPartMapper.fromEntity(PokeListPartEntity.fromJson(e)),
          )
          .toList(),
    );
  }
}
