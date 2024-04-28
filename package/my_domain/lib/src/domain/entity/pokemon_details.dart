import 'dart:typed_data';

class PokemonDetails {
  final int pokemonId;
  final Uint8List? image;
  final String name;
  final List<String> types;
  final int height;
  final int weight;

  PokemonDetails({
    required this.pokemonId,
    required this.image,
    required this.name,
    required this.types,
    required this.height,
    required this.weight,
  });
}
