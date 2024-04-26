import 'package:clear_pokemon/domain/entity/pokemon_details.dart';
import 'package:clear_pokemon/domain/repository/pokemon_repository.dart';
import 'package:clear_pokemon/domain/usecases/usecase.dart';

class GetPokemonDetailsUsecase implements UseCase<PokemonDetails, int> {
  final PokemonRepository pokemonRepository;

  GetPokemonDetailsUsecase({required this.pokemonRepository});

  @override
  Future<PokemonDetails> call({int params = 0}) async {
    return pokemonRepository.getPokemonDetails(params);
  }
}
