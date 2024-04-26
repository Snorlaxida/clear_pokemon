import 'package:clear_pokemon/data/data_sources/local/pokemon_db_service.dart';
import 'package:clear_pokemon/data/data_sources/remote/pokemon_api_service.dart';
import 'package:clear_pokemon/data/model/poke_page_model.dart';
import 'package:clear_pokemon/domain/entity/poke_page.dart';
import 'package:clear_pokemon/domain/entity/pokemon_details.dart';
import 'package:clear_pokemon/domain/repository/pokemon_repository.dart';

const baseUrl = 'pokeapi.co';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonApiService pokemonApiService;
  final DatabaseService databaseService;

  PokemonRepositoryImpl({
    required this.pokemonApiService,
    required this.databaseService,
  });

  @override
  Future<PokemonDetails> getPokemonDetails(int pokemonId) async {
    final pokeDetailsModel =
        await pokemonApiService.getPokemonDetails(pokemonId);

    return pokeDetailsModel.toEntity();
  }

  @override
  Future<PokePage> getPokemonPage({int startWith = 0}) async {
    final pokePageModel = await pokemonApiService.getPokemonPage();
    return pokePageModel.toEntity();
  }

  @override
  Future<PokePage> getPokemonPageFromDb() async {
    final pokeListPartModel = await databaseService.getAllPokeListParts();

    return PokePageModel(hasNext: false, pokeList: pokeListPartModel)
        .toEntity();
  }
}
