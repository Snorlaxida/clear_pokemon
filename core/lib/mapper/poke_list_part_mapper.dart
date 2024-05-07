import 'package:data/data.dart' show PokeListPartEntity;
import 'package:domain/domain.dart' show PokeListPart;
import '../utils/extensions.dart';

class PokeListPartMapper {
  static PokeListPart fromEntity(PokeListPartEntity pokeListPartEntity) {
    final int id = int.parse(pokeListPartEntity.url.split('/')[6]);
    return PokeListPart(
      name: pokeListPartEntity.name.capitalizeFirstLetter(),
      id: id,
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
    );
  }
}
