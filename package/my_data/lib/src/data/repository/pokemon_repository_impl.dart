import 'package:my_data/src/data/data_sources/local/pokemon_db_service.dart';
import 'package:my_data/src/data/data_sources/remote/pokemon_api_service.dart';
import 'package:my_data/src/data/model/poke_page_model.dart';
import 'package:my_domain/my_domain.dart'
    show PokePage, PokemonDetails, PokemonRepository;

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
