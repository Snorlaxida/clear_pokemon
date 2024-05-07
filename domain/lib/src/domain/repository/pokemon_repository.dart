import '../entity/poke_page.dart';
import '../entity/pokemon_details.dart';

abstract class PokemonRepository {
  Future<PokePage> getPokemonPage({int startWith = 0});

  Future<PokemonDetails> getPokemonDetails(int pokemonId);
}
