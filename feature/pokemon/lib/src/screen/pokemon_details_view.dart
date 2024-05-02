import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/domain.dart' show PokemonDetails;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pokemon_details/pokemon_details_cubit.dart';
import '../widget/pokemon_type_widget.dart';

class PokemonDetailsView extends StatelessWidget {
  const PokemonDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonDetailsCubit, PokemonDetails?>(
      builder: (BuildContext context, PokemonDetails? state) {
        return Scaffold(
          appBar: AppBar(
            title: state != null
                ? Text(state.name.toUpperCase())
                : const CircularProgressIndicator(),
          ),
          body: state != null
              ? Column(
                  children: <Widget>[
                    Center(
                        child: CachedNetworkImage(
                      imageUrl: state.imageUrl,
                      placeholder: (BuildContext context, String url) =>
                          const CircularProgressIndicator(),
                      errorWidget:
                          (BuildContext context, String url, Object error) =>
                              const Icon(Icons.error),
                      imageBuilder: (BuildContext context,
                              ImageProvider<Object> imageProvider) =>
                          Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        )),
                      ),
                    )),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: state.types.map(pokemonTypeWidget).toList(),
                    ),
                    const SizedBox(height: 30),
                    Text.rich(TextSpan(
                      style: const TextStyle(fontSize: 20),
                      children: <InlineSpan>[
                        const TextSpan(text: 'Height: '),
                        TextSpan(
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            text: '${state.height} cm'),
                      ],
                    )),
                    Text.rich(TextSpan(
                      style: const TextStyle(fontSize: 20),
                      children: <InlineSpan>[
                        const TextSpan(text: 'Weight: '),
                        TextSpan(
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            text: '${state.weight} kg'),
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
