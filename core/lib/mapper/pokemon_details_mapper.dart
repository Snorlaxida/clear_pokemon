import 'package:data/data.dart' show PokemonDetailsEntity;
import 'package:domain/domain.dart' show PokemonDetails;

class PokemonDetailsMapper {
  static PokemonDetails fromEntity(PokemonDetailsEntity pokemonDetailsEntity) {
    return PokemonDetails(
      pokemonId: pokemonDetailsEntity.id,
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemonDetailsEntity.id}.png',
      name: pokemonDetailsEntity.name,
      types: pokemonDetailsEntity.types
          .map((Map<String, dynamic> e) => e['type']['name'].toString())
          .toList(),
      height: pokemonDetailsEntity.height,
      weight: pokemonDetailsEntity.weight,
    );
  }
}
