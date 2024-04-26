import 'package:clear_pokemon/domain/entity/poke_page.dart';
import 'package:clear_pokemon/domain/entity/pokemon_details.dart';

abstract class PokemonRepository {
  Future<PokePage> getPokemonPage({int startWith = 0});

  Future<PokePage> getPokemonPageFromDb();

  Future<PokemonDetails> getPokemonDetails(int pokemonId);
}
