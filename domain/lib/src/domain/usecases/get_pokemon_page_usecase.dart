import '../entity/poke_page.dart';
import '../repository/pokemon_repository.dart';
import 'usecase.dart';

class GetPokemonPageUsecase implements UseCase<PokePage, int> {
  final PokemonRepository pokemonRepository;

  GetPokemonPageUsecase({required this.pokemonRepository});

  @override
  Future<PokePage> call({int params = 0}) async {
    return pokemonRepository.getPokemonPage(startWith: params);
  }
}
