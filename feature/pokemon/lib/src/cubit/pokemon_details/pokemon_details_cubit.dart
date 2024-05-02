import 'package:domain/domain.dart'
    show GetPokemonDetailsUsecase, PokemonDetails;
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonDetailsCubit extends Cubit<PokemonDetails?> {
  PokemonDetailsCubit({required this.getPokemonDetailsUsecase}) : super(null);

  final GetPokemonDetailsUsecase getPokemonDetailsUsecase;

  Future<void> getPokemonDetails(int pokemonId) async {
    final PokemonDetails pokemonInfo =
        await getPokemonDetailsUsecase.call(params: pokemonId);

    emit(PokemonDetails(
      pokemonId: pokemonInfo.pokemonId,
      name: pokemonInfo.name,
      imageUrl: pokemonInfo.imageUrl,
      types: pokemonInfo.types,
      height: pokemonInfo.height,
      weight: pokemonInfo.weight,
    ));
  }

  void clearPokemonDetails() => emit(null);
}
