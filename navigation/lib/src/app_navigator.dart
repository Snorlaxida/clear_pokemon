import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pokemon/pokemon.dart' show PokedexView, PokemonDetailsView;

import 'cubit/nav_cubit.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, int?>(
      builder: (BuildContext context, int? pokemonId) {
        return Navigator(
          pages: <Page<dynamic>>[
            const MaterialPage<dynamic>(child: PokedexView()),
            if (pokemonId != null)
              const MaterialPage<dynamic>(child: PokemonDetailsView()),
          ],
          onPopPage: (Route<dynamic> route, dynamic result) {
            context.read<NavCubit>().popToPokedex();
            return route.didPop(result);
          },
        );
      },
    );
  }
}
