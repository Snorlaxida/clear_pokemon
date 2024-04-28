import 'package:my_domain/src/domain/entity/pokemon_details.dart';
import 'package:my_domain/src/domain/repository/pokemon_repository.dart';
import 'package:my_domain/src/domain/usecases/usecase.dart';

class GetPokemonDetailsUsecase implements UseCase<PokemonDetails, int> {
  final PokemonRepository pokemonRepository;

  GetPokemonDetailsUsecase({required this.pokemonRepository});

  @override
  Future<PokemonDetails> call({int params = 0}) async {
    return pokemonRepository.getPokemonDetails(params);
  }
}
