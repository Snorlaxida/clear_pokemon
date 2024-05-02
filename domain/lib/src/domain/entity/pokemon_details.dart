class PokemonDetails {
  final int pokemonId;
  final String imageUrl;
  final String name;
  final List<String> types;
  final int height;
  final int weight;

  PokemonDetails({
    required this.pokemonId,
    required this.imageUrl,
    required this.name,
    required this.types,
    required this.height,
    required this.weight,
  });
}
