import 'package:my_domain/src/domain/entity/poke_page.dart';
import 'package:my_domain/src/domain/repository/pokemon_repository.dart';
import 'package:my_domain/src/domain/usecases/usecase.dart';

class GetPokemonPageFromDbUsecase implements UseCase<PokePage, void> {
  final PokemonRepository pokemonRepository;

  GetPokemonPageFromDbUsecase({required this.pokemonRepository});

  @override
  Future<PokePage> call({void params}) async {
    return pokemonRepository.getPokemonPageFromDb();
  }
}
