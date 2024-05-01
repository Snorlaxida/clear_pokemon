import 'dart:convert';
import 'dart:typed_data' show Uint8List;
import 'package:domain/domain.dart' show PokemonDetails;

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
    final int pokemonId = json['id'];
    final String name = json['name'];
    final Uint8List? image =
        json['sprites']['other']['official-artwork']['front_default'];
    final List<String> types = (json['types'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map((Map<String, dynamic> e) => e['type']['name'] as String)
        .toList();
    final int height = json['height'];
    final int weight = json['weight'];

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
    final int pokemonId = json['id'];
    final String name = json['name'];
    final Uint8List? image = json['image'];
    final List<String> types = (jsonDecode(json['types']) as List<dynamic>)
        .cast<String>()
        .map((String e) => e)
        .toList();
    final int height = json['height'];
    final int weight = json['weight'];

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
    return <String, dynamic>{
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
