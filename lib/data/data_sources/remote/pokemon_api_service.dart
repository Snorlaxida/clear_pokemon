import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:clear_pokemon/data/data_sources/local/pokemon_db_service.dart';
import 'package:clear_pokemon/data/model/poke_page_model.dart';
import 'package:clear_pokemon/data/model/pokemon_details_model.dart';

const baseUrl = 'pokeapi.co';

class PokemonApiService {
  final client = Dio();
  Future<PokePageModel> getPokemonPage({int startWith = 0}) async {
    final queryParameters = {
      'limit': '20',
      'offset': startWith.toString(),
    };

    final uri = Uri.https(baseUrl, 'api/v2/pokemon', queryParameters);
    final response = await client.getUri(uri);
    final json = response.data;

    return PokePageModel.fromJson(json);
  }

  Future<PokemonDetailsModel> getPokemonDetails(int pokemonId) async {
    final uri = Uri.https(baseUrl, 'api/v2/pokemon/$pokemonId');
    final pokemonDetail = await DatabaseService.getPokemonDetails(pokemonId);
    if (pokemonDetail != null) {
      return pokemonDetail;
    }
    try {
      final response = await client.getUri(uri);
      final json = response.data;
      json['sprites']['other']['official-artwork']['front_default'] =
          await _convertImageUrlToUint8List(
              json['sprites']['other']['official-artwork']['front_default']);
      await DatabaseService.addPokemon(PokemonDetailsModel.fromJson(json));
      return PokemonDetailsModel.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }
}

Future<Uint8List> _convertImageUrlToUint8List(String url) async {
  final bundle = NetworkAssetBundle(Uri.parse(url));
  final data = (await bundle.load(url)).buffer.asUint8List();
  return data;
}
