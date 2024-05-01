import '../entity/poke_page.dart';
import '../repository/pokemon_repository.dart';
import 'usecase.dart';

class GetPokemonPageFromDbUsecase implements UseCase<PokePage, void> {
  final PokemonRepository pokemonRepository;

  GetPokemonPageFromDbUsecase({required this.pokemonRepository});

  @override
  Future<PokePage> call({void params}) async {
    return pokemonRepository.getPokemonPageFromDb();
  }
}
