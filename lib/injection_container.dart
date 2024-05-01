import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:navigation/navigation.dart';
import 'package:pokemon/pokemon.dart';
import 'package:sqflite/sqflite.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<Database>(await DatabaseService.getDb());

  sl.registerSingleton<DatabaseService>(
      DatabaseService(database: sl.get<Database>()));

  sl.registerSingleton<PokemonApiService>(PokemonApiService(
      client: sl.get<Dio>(), databaseService: sl.get<DatabaseService>()));

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
