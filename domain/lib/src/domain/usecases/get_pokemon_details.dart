import '../entity/pokemon_details.dart';
import '../repository/pokemon_repository.dart';
import 'usecase.dart';

class GetPokemonDetailsUsecase implements UseCase<PokemonDetails, int> {
  final PokemonRepository pokemonRepository;

  GetPokemonDetailsUsecase({required this.pokemonRepository});

  @override
  Future<PokemonDetails> call({int params = 0}) async {
    return pokemonRepository.getPokemonDetails(params);
  }
}
