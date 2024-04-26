import 'package:clear_pokemon/domain/entity/poke_page.dart';
import 'package:clear_pokemon/domain/repository/pokemon_repository.dart';
import 'package:clear_pokemon/domain/usecases/usecase.dart';

class GetPokemonPageFromDbUsecase implements UseCase<PokePage, void> {
  final PokemonRepository pokemonRepository;

  GetPokemonPageFromDbUsecase({required this.pokemonRepository});

  @override
  Future<PokePage> call({void params}) async {
    return pokemonRepository.getPokemonPageFromDb();
  }
}
