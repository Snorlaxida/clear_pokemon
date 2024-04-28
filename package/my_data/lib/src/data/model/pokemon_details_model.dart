import 'dart:convert';
import 'dart:typed_data' show Uint8List;
import 'package:my_domain/my_domain.dart' show PokemonDetails;

class PokemonDetailsModel {
  final int pokemonId;
  final Uint8List? image;
  final String name;
  final List<String> types;
  final int height;
  final int weight;

  PokemonDetailsModel({
    required this.pokemonId,
    required this.image,
    required this.name,
    required this.types,
    required this.height,
    required this.weight,
  });

  factory PokemonDetailsModel.fromJson(Map<String, dynamic> json) {
    final pokemonId = json['id'];
    final name = json['name'];
    final image = json['sprites']['other']['official-artwork']['front_default'];
    final types = (json['types'] as List)
        .map((e) => e['type']['name'] as String)
        .toList();
    final height = json['height'];
    final weight = json['weight'];

    return PokemonDetailsModel(
      pokemonId: pokemonId,
      image: image,
      name: name,
      types: types,
      height: height,
      weight: weight,
    );
  }

  factory PokemonDetailsModel.fromDbJson(Map<String, dynamic> json) {
    final pokemonId = json['id'];
    final name = json['name'];
    final image = json['image'];
    final types =
        (jsonDecode(json['types']) as List).map((e) => e as String).toList();
    final height = json['height'];
    final weight = json['weight'];

    return PokemonDetailsModel(
      pokemonId: pokemonId,
      image: image,
      name: name,
      types: types,
      height: height,
      weight: weight,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': pokemonId,
      'image': image,
      'name': name,
      'types': jsonEncode(types),
      'height': height,
      'weight': weight,
    };
  }

  PokemonDetails toEntity() {
    return PokemonDetails(
      pokemonId: pokemonId,
      image: image,
      name: name,
      types: types,
      height: height,
      weight: weight,
    );
  }
}
