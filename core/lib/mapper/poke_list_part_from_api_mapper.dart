import 'package:data/data.dart' show PokeListPartFromApiEntity;
import 'package:domain/domain.dart' show PokeListPart;
import '../utils/extensions.dart';

class PokeListPartFromApiMapper {
  static PokeListPart toModel(
      PokeListPartFromApiEntity pokeListPartFromApiEntity) {
    final int id = int.parse(pokeListPartFromApiEntity.url.split('/')[6]);
    return PokeListPart(
      name: pokeListPartFromApiEntity.name.capitalizeFirstLetter(),
      id: id,
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
    );
  }

  static PokeListPartModel fromDbJson(Map<String, dynamic> json) {
    final String nameLowerCase = json['name'] as String;
    final String name = nameLowerCase.capitalizeFirstLetter();
    final int id = json['id'];
    final String imageUrl = json['image'];
    return PokeListPartModel(name: name, id: id, imageUrl: imageUrl);
  }
}
