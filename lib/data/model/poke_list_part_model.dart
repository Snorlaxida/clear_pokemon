import 'dart:typed_data';

import 'package:clear_pokemon/domain/entity/poke_list_part.dart';

class PokeListPartModel {
  final String name;
  final int id;
  final Uint8List? image;

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

  PokeListPartModel({this.image, required this.name, required this.id});

  factory PokeListPartModel.fromJson(Map<String, dynamic> json) {
    final nameLowerCase = json['name'] as String;
    final name = nameLowerCase.replaceFirst(
      nameLowerCase[0],
      nameLowerCase[0].toUpperCase(),
    );
    final id = int.parse(json['url'].toString().split('/')[6]);
    return PokeListPartModel(name: name, id: id);
  }

  factory PokeListPartModel.fromDbJson(Map<String, dynamic> json) {
    final nameLowerCase = json['name'] as String;
    final name = nameLowerCase.replaceFirst(
      nameLowerCase[0],
      nameLowerCase[0].toUpperCase(),
    );
    final id = json['id'];
    final image = json['image'];
    return PokeListPartModel(name: name, id: id, image: image);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  PokeListPart toEntity() {
    return PokeListPart(
      name: name,
      id: id,
      image: image,
    );
  }
}
