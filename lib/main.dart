import 'package:clear_pokemon/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_presentation/my_presentation.dart';

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
        providers: [
          BlocProvider<PokeBloc>(
            create: (context) => sl(),
          ),
          BlocProvider<NavCubit>(
            create: (context) => sl(),
          ),
          BlocProvider<InternetCubit>(
            create: (context) => sl(),
          ),
          BlocProvider<PokemonDetailsCubit>(
            create: (context) => sl(),
          ),
        ],
        child: const AppNavigator(),
      ),
    );
  }
}
