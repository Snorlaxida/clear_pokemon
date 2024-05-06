import 'dart:convert';
import 'package:data/data.dart'
    show PokemonDetailsFromApiEntity, PokemonDetailsFromDbEntity;
import 'package:domain/domain.dart' show PokemonDetails;

class PokemonDetailsMapper {
  static PokemonDetails toModel(PokemonDetailsModel pokemonDetailsModel) {
    return PokemonDetails(
      pokemonId: pokemonDetailsModel.pokemonId,
      imageUrl: pokemonDetailsModel.imageUrl,
      name: pokemonDetailsModel.name,
      types: pokemonDetailsModel.types,
      height: pokemonDetailsModel.height,
      weight: pokemonDetailsModel.weight,
    );
  }

  static PokemonDetailsModel fromDbJson(Map<String, dynamic> json) {
    final int pokemonId = json['id'];
    final String name = json['name'];
    final String imageUrl = json['image'];
    final List<String> types = (jsonDecode(json['types']) as List<dynamic>)
        .cast<String>()
        .map((String e) => e)
        .toList();
    final int height = json['height'];
    final int weight = json['weight'];

    return PokemonDetailsModel(
      pokemonId: pokemonId,
      imageUrl: imageUrl,
      name: name,
      types: types,
      height: height,
      weight: weight,
    );
  }
}
