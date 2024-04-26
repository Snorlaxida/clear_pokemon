import 'package:clear_pokemon/domain/entity/pokemon_details.dart';
import 'package:clear_pokemon/presentation/cubit/pokemon_details/pokemon_details_cubit.dart';
import 'package:clear_pokemon/presentation/widgets/pokemon_type_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonDetailsView extends StatelessWidget {
  const PokemonDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonDetailsCubit, PokemonDetails?>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: state != null
                ? Text(state.name.toUpperCase())
                : const CircularProgressIndicator(),
          ),
          body: state != null
              ? Column(
                  children: [
                    Center(
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: Image.memory(
                                  state.image!,
                                ).image,
                                fit: BoxFit.cover)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          state.types.map((e) => pokemonTypeWidget(e)).toList(),
                    ),
                    const SizedBox(height: 30),
                    Text.rich(TextSpan(
                      style: const TextStyle(fontSize: 20),
                      children: [
                        const TextSpan(text: "Height: "),
                        TextSpan(
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            text: '${state.height.toString()} cm'),
                      ],
                    )),
                    Text.rich(TextSpan(
                      style: const TextStyle(fontSize: 20),
                      children: [
                        const TextSpan(text: "Weight: "),
                        TextSpan(
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            text: '${state.weight.toString()} kg'),
                      ],
                    )),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
