import 'package:core/mapper/poke_page_mapper.dart';
import 'package:core/mapper/pokemon_details_mapper.dart';
import 'package:domain/domain.dart'
    show PokePage, PokemonDetails, PokemonRepository;
import '../data_sources/remote/pokemon_api_service.dart';
import '../entity/poke_page/poke_page_entity.dart';
import '../entity/pokemon_details/pokemon_details_entity.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonApiService pokemonApiService;

  PokemonRepositoryImpl({
    required this.pokemonApiService,
  });

  @override
  Future<PokemonDetails> getPokemonDetails(int pokemonId) async {
    final PokemonDetailsEntity pokeDetailsModel =
        await pokemonApiService.getPokemonDetails(pokemonId);

    return PokemonDetailsMapper.fromEntity(pokeDetailsModel);
  }

  @override
  Future<PokePage> getPokemonPage({int startWith = 0}) async {
    final PokePageEntity pokePageEntity =
        await pokemonApiService.getPokemonPage(startWith: startWith);
    return PokePageMapper.fromEntity(pokePageEntity);
  }
}
