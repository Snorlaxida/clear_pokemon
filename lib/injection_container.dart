import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:my_data/data.dart';
import 'package:my_domain/my_domain.dart';
import 'package:my_presentation/my_presentation.dart';

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
