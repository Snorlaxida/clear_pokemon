import 'package:clear_pokemon/data/data_sources/local/pokemon_db_service.dart';
import 'package:clear_pokemon/data/data_sources/remote/pokemon_api_service.dart';
import 'package:clear_pokemon/data/repository/pokemon_repository_impl.dart';
import 'package:clear_pokemon/domain/repository/pokemon_repository.dart';
import 'package:clear_pokemon/domain/usecases/get_pokemon_details.dart';
import 'package:clear_pokemon/domain/usecases/get_pokemon_page_from_db.dart';
import 'package:clear_pokemon/domain/usecases/get_pokemon_page_usecase.dart';
import 'package:clear_pokemon/presentation/bloc/pokemon/poke_bloc.dart';
import 'package:clear_pokemon/presentation/cubit/internet/internet_cubit.dart';
import 'package:clear_pokemon/presentation/cubit/navigation/nav_cubit.dart';
import 'package:clear_pokemon/presentation/cubit/pokemon_details/pokemon_details_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<PokemonApiService>(
      PokemonApiService(client: sl.get<Dio>()));

  sl.registerSingleton<DatabaseService>(DatabaseService());

  sl.registerSingleton<PokemonRepository>(
    PokemonRepositoryImpl(
      pokemonApiService: sl.get<PokemonApiService>(),
      databaseService: sl.get<DatabaseService>(),
    ),
  );

  sl.registerSingleton<GetPokemonDetailsUsecase>(GetPokemonDetailsUsecase(
    pokemonRepository: sl.get<PokemonRepository>(),
  ));

  sl.registerSingleton<GetPokemonPageUsecase>(GetPokemonPageUsecase(
    pokemonRepository: sl.get<PokemonRepository>(),
  ));

  sl.registerSingleton<GetPokemonPageFromDbUsecase>(GetPokemonPageFromDbUsecase(
    pokemonRepository: sl.get<PokemonRepository>(),
  ));

  sl.registerFactory<PokeBloc>(
    () => PokeBloc(
      pokemonPageUsecase: sl.get<GetPokemonPageUsecase>(),
      pokemonPageFromDbUsecase: sl.get<GetPokemonPageFromDbUsecase>(),
    ),
  );

  sl.registerSingleton<PokemonDetailsCubit>(PokemonDetailsCubit(
      getPokemonDetailsUsecase: sl.get<GetPokemonDetailsUsecase>()));

  sl.registerFactory<NavCubit>(
      () => NavCubit(pokemonDetailsCubit: sl.get<PokemonDetailsCubit>()));

  sl.registerSingleton<Connectivity>(Connectivity());

  sl.registerFactory<InternetCubit>(
      () => InternetCubit(connectivity: sl.get<Connectivity>()));
}
