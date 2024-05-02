import 'package:data/data.dart' show PokeListPartModel;
import 'package:domain/domain.dart' show PokeListPart;
import '../utils/convert_first_letter_to_uppercase.dart';

class PokeListPartMapper {
  PokeListPart toEntity(PokeListPartModel pokeListPart) {
    return PokeListPart(
      name: convertFirstLetterToUppercase(pokeListPart.name),
      id: pokeListPart.id,
      imageUrl: pokeListPart.imageUrl,
    );
  }

  PokeListPartModel fromDbJson(Map<String, dynamic> json) {
    final String nameLowerCase = json['name'] as String;
    final String name = nameLowerCase.replaceFirst(
      nameLowerCase[0],
      nameLowerCase[0].toUpperCase(),
    );
    final int id = json['id'];
    final String imageUrl = json['image'];
    return PokeListPartModel(name: name, id: id, imageUrl: imageUrl);
  }
}
