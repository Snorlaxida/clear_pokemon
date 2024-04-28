import 'package:my_domain/src/domain/entity/poke_page.dart';
import 'package:my_domain/src/domain/entity/pokemon_details.dart';

abstract class PokemonRepository {
  Future<PokePage> getPokemonPage({int startWith = 0});

  Future<PokePage> getPokemonPageFromDb();

  Future<PokemonDetails> getPokemonDetails(int pokemonId);
}
