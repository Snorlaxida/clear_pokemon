import 'package:clear_pokemon/data/data_sources/local/pokemon_db_service.dart';
import 'package:clear_pokemon/data/data_sources/remote/pokemon_api_service.dart';
import 'package:clear_pokemon/data/repository/pokemon_repository_impl.dart';
import 'package:clear_pokemon/domain/usecases/get_pokemon_details.dart';
import 'package:clear_pokemon/domain/usecases/get_pokemon_page_from_db.dart';
import 'package:clear_pokemon/domain/usecases/get_pokemon_page_usecase.dart';
import 'package:clear_pokemon/presentation/bloc/pokemon/poke_bloc.dart';
import 'package:clear_pokemon/presentation/cubit/internet/internet_cubit.dart';
import 'package:clear_pokemon/presentation/cubit/navigation/nav_cubit.dart';
import 'package:clear_pokemon/presentation/cubit/pokemon_details/pokemon_details_cubit.dart';
import 'package:clear_pokemon/presentation/navigation/app_navigator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final pokeApiService = PokemonApiService();
    final databaseService = DatabaseService();
    final pokemonRepository = PokemonRepositoryImpl(
      pokemonApiService: pokeApiService,
      databaseService: databaseService,
    );
    final getPokemonPageUsecase =
        GetPokemonPageUsecase(pokemonRepository: pokemonRepository);
    final getPokemonDetailsUsecase =
        GetPokemonDetailsUsecase(pokemonRepository: pokemonRepository);
    final getPokemonPageFromDbUsecase =
        GetPokemonPageFromDbUsecase(pokemonRepository: pokemonRepository);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Colors.red, centerTitle: true)),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => PokemonDetailsCubit(
                getPokemonDetailsUsecase: getPokemonDetailsUsecase),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => PokeBloc(
                pokemonPageUsecase: getPokemonPageUsecase,
                pokemonPageFromDbUsecase: getPokemonPageFromDbUsecase,
              ),
            ),
            BlocProvider(
              create: (context) => NavCubit(
                  pokemonDetailsCubit: context.read<PokemonDetailsCubit>()),
            ),
            BlocProvider(
              create: (context) => InternetCubit(connectivity: Connectivity()),
            ),
          ],
          child: const AppNavigator(),
        ),
      ),
    );
  }
}
