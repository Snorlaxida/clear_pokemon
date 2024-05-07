import 'package:data/api_core/helpers/interceptors/exception_interceptor.dart';
import 'package:data/api_core/helpers/interceptors/logger_interceptor.dart';
import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:navigation/navigation.dart';
import 'package:pokemon/pokemon.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<LoggerInterceptor>(LoggerInterceptor());
  sl.registerSingleton<ErrorInterceptor>(ErrorInterceptor());
  sl.registerSingleton<Dio>(Dio()
    ..interceptors.addAll(<Interceptor>[
      sl.get<LoggerInterceptor>(),
      sl.get<ErrorInterceptor>()
    ]));

  sl.registerSingleton<PokemonApiService>(
      PokemonApiService(client: sl.get<Dio>()));

  sl.registerSingleton<PokemonRepository>(
    PokemonRepositoryImpl(pokemonApiService: sl.get<PokemonApiService>()),
  );

  sl.registerSingleton<GetPokemonDetailsUsecase>(GetPokemonDetailsUsecase(
    pokemonRepository: sl.get<PokemonRepository>(),
  ));

  sl.registerSingleton<GetPokemonPageUsecase>(GetPokemonPageUsecase(
    pokemonRepository: sl.get<PokemonRepository>(),
  ));

  sl.registerFactory<PokeBloc>(
    () => PokeBloc(pokemonPageUsecase: sl.get<GetPokemonPageUsecase>()),
  );

  sl.registerSingleton<PokemonDetailsCubit>(PokemonDetailsCubit(
      getPokemonDetailsUsecase: sl.get<GetPokemonDetailsUsecase>()));

  sl.registerFactory<NavCubit>(
      () => NavCubit(pokemonDetailsCubit: sl.get<PokemonDetailsCubit>()));
}
