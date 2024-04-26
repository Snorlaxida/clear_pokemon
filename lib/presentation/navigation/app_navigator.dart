import 'package:clear_pokemon/presentation/cubit/navigation/nav_cubit.dart';
import 'package:clear_pokemon/presentation/views/pokedex_view.dart';
import 'package:clear_pokemon/presentation/views/pokemon_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, int?>(
      builder: (context, pokemonId) {
        return Navigator(
          pages: [
            const MaterialPage(child: PokedexView()),
            if (pokemonId != null)
              const MaterialPage(child: PokemonDetailsView()),
          ],
          onPopPage: (route, result) {
            context.read<NavCubit>().popToPokedex();
            return route.didPop(result);
          },
        );
      },
    );
  }
}