import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';

import '../bloc/poke_bloc.dart';
import '../cubit/internet/internet_cubit.dart';

class PokedexView extends StatefulWidget {
  const PokedexView({super.key});

  @override
  State<PokedexView> createState() => _PokedexViewState();
}

class _PokedexViewState extends State<PokedexView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<PokeBloc>().add(LoadPokemonsEvent());
    }
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final double maxScroll = scrollController.position.maxScrollExtent;
    final double currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: BlocListener<InternetCubit, InternetState>(
        listener: (BuildContext context, InternetState state) {
          if (state.type == InternetTypes.offline) {
            context.read<PokeBloc>().add(NoInternetEvent());
          } else if (state.type == InternetTypes.connected) {
            context.read<PokeBloc>().add(LoadPokemonsEvent());
          }
        },
        child: BlocBuilder<PokeBloc, PokeState>(
          builder: (BuildContext context, PokeState state) {
            switch (state.status) {
              case PokeStatus.initial:
                return const Center(child: CircularProgressIndicator());
              case PokeStatus.offline:
                if (state.pokeList.isEmpty) {
                  return const Center(child: Text('No cached pokemons'));
                }
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: state.pokeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        context
                            .read<NavCubit>()
                            .showPokemonDetails(state.pokeList[index].id);
                      },
                      child: Card(
                        child: GridTile(
                          child: Column(
                            children: <Widget>[
                              CachedNetworkImage(
                                imageUrl: state.pokeList[index].imageUrl,
                                imageBuilder: (BuildContext context,
                                        ImageProvider<Object> imageProvider) =>
                                    Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              Text(state.pokeList[index].name)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              case PokeStatus.failure:
                return const Center(child: Text('Failed to load pokemons!'));
              case PokeStatus.success:
                if (state.pokeList.isEmpty) {
                  return const Center(child: Text('No pokemons'));
                }
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: state.hasReachedMax
                      ? state.pokeList.length
                      : state.pokeList.length + 1,
                  controller: scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.pokeList.length
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : GestureDetector(
                            onTap: () {
                              context
                                  .read<NavCubit>()
                                  .showPokemonDetails(state.pokeList[index].id);
                            },
                            child: Card(
                              child: GridTile(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: Image.network(
                                                state.pokeList[index].imageUrl,
                                              ).image,
                                              fit: BoxFit.cover)),
                                    ),
                                    Text(state.pokeList[index].name)
                                  ],
                                ),
                              ),
                            ),
                          );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
