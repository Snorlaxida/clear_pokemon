import 'package:core/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import '../../model/poke_page_model.dart';
import '../../model/pokemon_details_model.dart';
import '../local/pokemon_db_service.dart';

class PokemonApiService {
  final Dio client;
  final DatabaseService databaseService;

  PokemonApiService({
    required this.databaseService,
    required this.client,
  });

  Future<PokePageModel> getPokemonPage({int startWith = 0}) async {
    final Map<String, String> queryParameters = <String, String>{
      'limit': '20',
      'offset': startWith.toString(),
    };

    final Uri uri = Uri.https(baseUrl, 'api/v2/pokemon', queryParameters);
    final Response<dynamic> response = await client.getUri(uri);
    final Map<String, dynamic> json = response.data;

    return PokePageModel.fromJson(json);
  }

  Future<PokemonDetailsModel> getPokemonDetails(int pokemonId) async {
    final Uri uri = Uri.https(baseUrl, 'api/v2/pokemon/$pokemonId');
    final PokemonDetailsModel? pokemonDetail =
        await databaseService.getPokemonDetails(pokemonId);
    if (pokemonDetail != null) {
      return pokemonDetail;
    }
    try {
      final Response<dynamic> response = await client.getUri(uri);
      final Map<String, dynamic> json = response.data;
      json['sprites']['other']['official-artwork']['front_default'] =
          await _convertImageUrlToUint8List(
              json['sprites']['other']['official-artwork']['front_default']);
      await databaseService.addPokemon(PokemonDetailsModel.fromJson(json));
      return PokemonDetailsModel.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }
}

Future<Uint8List> _convertImageUrlToUint8List(String url) async {
  final NetworkAssetBundle bundle = NetworkAssetBundle(Uri.parse(url));
  final Uint8List data = (await bundle.load(url)).buffer.asUint8List();
  return data;
}
