import 'package:my_domain/src/domain/entity/poke_page.dart';
import 'package:my_domain/src/domain/repository/pokemon_repository.dart';
import 'package:my_domain/src/domain/usecases/usecase.dart';

class GetPokemonPageUsecase implements UseCase<PokePage, int> {
  final PokemonRepository pokemonRepository;

  GetPokemonPageUsecase({required this.pokemonRepository});

  @override
  Future<PokePage> call({int params = 0}) async {
    return pokemonRepository.getPokemonPage(startWith: params);
  }
}
