import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_domain/my_domain.dart'
    show GetPokemonDetailsUsecase, PokemonDetails;

class PokemonDetailsCubit extends Cubit<PokemonDetails?> {
  PokemonDetailsCubit({required this.getPokemonDetailsUsecase}) : super(null);

  final GetPokemonDetailsUsecase getPokemonDetailsUsecase;

  void getPokemonDetails(int pokemonId) async {
    final pokemonInfo = await getPokemonDetailsUsecase.call(params: pokemonId);

    emit(PokemonDetails(
      pokemonId: pokemonInfo.pokemonId,
      name: pokemonInfo.name,
      image: pokemonInfo.image,
      types: pokemonInfo.types,
      height: pokemonInfo.height,
      weight: pokemonInfo.weight,
    ));
  }

  void clearPokemonDetails() => emit(null);
}
