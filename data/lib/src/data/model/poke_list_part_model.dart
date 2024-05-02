import 'package:freezed_annotation/freezed_annotation.dart';

part 'poke_list_part_model.g.dart';

@JsonSerializable()
class PokeListPartModel {
  final String name;
  final int id;
  final String imageUrl;

  PokeListPartModel(
      {required this.imageUrl, required this.name, required this.id});

  factory PokeListPartModel.fromJson(Map<String, dynamic> json) =>
      _$PokeListPartModelFromJson(json);
}
