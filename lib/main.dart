import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:nested/nested.dart';
import 'package:pokemon/pokemon.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Colors.red, centerTitle: true)),
      home: MultiBlocProvider(
        providers: <SingleChildWidget>[
          BlocProvider<PokeBloc>(
            create: (BuildContext context) => sl(),
          ),
          BlocProvider<NavCubit>(
            create: (BuildContext context) => sl(),
          ),
          BlocProvider<InternetCubit>(
            create: (BuildContext context) => sl(),
          ),
          BlocProvider<PokemonDetailsCubit>(
            create: (BuildContext context) => sl(),
          ),
        ],
        child: const AppNavigator(),
      ),
    );
  }
}
