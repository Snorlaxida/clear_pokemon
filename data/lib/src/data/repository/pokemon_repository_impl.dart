import 'package:core/mapper/poke_page_mapper.dart';
import 'package:core/mapper/pokemon_details_mapper.dart';
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

    return PokemonDetailsMapper.toModel(pokeDetailsModel);
  }

  @override
  Future<PokePage> getPokemonPage({int startWith = 0}) async {
    final PokePageModel pokePageModel =
        await pokemonApiService.getPokemonPage(startWith: startWith);
    return PokePageMapper.toEntity(pokePageModel);
  }

  @override
  Future<PokePage> getPokemonPageFromDb() async {
    final List<PokeListPartModel>? pokeListPartModel =
        await databaseService.getAllPokeListParts();

    return PokePageMapper.toEntity(
      PokePageModel(
        hasNext: false,
        pokeList: pokeListPartModel,
      ),
    );
  }
}
