import 'dart:typed_data' show Uint8List;

import 'package:domain/domain.dart';

class PokeListPartModel {
  final String name;
  final int id;
  final Uint8List? image;
  final String imageUrls = 'ds';

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

  PokeListPartModel({this.image, required this.name, required this.id});

  factory PokeListPartModel.fromJson(Map<String, dynamic> json) {
    final String nameLowerCase = json['name'] as String;
    final String name = nameLowerCase.replaceFirst(
      nameLowerCase[0],
      nameLowerCase[0].toUpperCase(),
    );
    final int id = int.parse(json['url'].toString().split('/')[6]);
    return PokeListPartModel(name: name, id: id);
  }

  factory PokeListPartModel.fromDbJson(Map<String, dynamic> json) {
    final String nameLowerCase = json['name'] as String;
    final String name = nameLowerCase.replaceFirst(
      nameLowerCase[0],
      nameLowerCase[0].toUpperCase(),
    );
    final int id = json['id'];
    final Uint8List image = json['image'];
    return PokeListPartModel(name: name, id: id, image: image);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
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
