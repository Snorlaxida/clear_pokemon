import 'package:domain/domain.dart'
    show PokePage, PokemonDetails, PokemonRepository;
import '../data_sources/local/pokemon_db_service.dart';
import '../data_sources/remote/pokemon_api_service.dart';
import '../model/poke_list_part_model.dart';
import '../model/poke_page_model.dart';
import '../model/pokemon_details_model.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonApiService pokemonApiService;
  final DatabaseService databaseService;

  PokemonRepositoryImpl({
    required this.pokemonApiService,
    required this.databaseService,
  });

  @override
  Future<PokemonDetails> getPokemonDetails(int pokemonId) async {
    final PokemonDetailsModel pokeDetailsModel =
        await pokemonApiService.getPokemonDetails(pokemonId);

    return pokeDetailsModel.toEntity();
  }

  @override
  Future<PokePage> getPokemonPage({int startWith = 0}) async {
    final PokePageModel pokePageModel =
        await pokemonApiService.getPokemonPage(startWith: startWith);
    return pokePageModel.toEntity();
  }

  @override
  Future<PokePage> getPokemonPageFromDb() async {
    final List<PokeListPartModel>? pokeListPartModel =
        await databaseService.getAllPokeListParts();

    return PokePageModel(hasNext: false, pokeList: pokeListPartModel)
        .toEntity();
  }
}
