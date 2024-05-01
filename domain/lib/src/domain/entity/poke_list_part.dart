import 'dart:typed_data';

class PokeListPart {
  final String name;
  final int id;
  final Uint8List? image;

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

  PokeListPart({
    required this.name,
    required this.id,
    required this.image,
  });
}
