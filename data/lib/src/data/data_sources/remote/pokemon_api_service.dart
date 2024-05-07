import 'package:core/constants/constants.dart';
import 'package:dio/dio.dart';
import '../../entity/poke_page/poke_page_entity.dart';
import '../../entity/pokemon_details/pokemon_details_entity.dart';

class PokemonApiService {
  final Dio client;

  PokemonApiService({
    required this.client,
  });

  Future<PokePageEntity> getPokemonPage({int startWith = 0}) async {
    final Map<String, String> queryParameters = <String, String>{
      'limit': '20',
      'offset': startWith.toString(),
    };
    final Uri uri = Uri.https(baseUrl, 'api/v2/pokemon', queryParameters);
    final Response<dynamic> response = await client.getUri(uri);
    final Map<String, dynamic> json = response.data;

    return PokePageEntity.fromJson(json);
  }

  Future<PokemonDetailsEntity> getPokemonDetails(int pokemonId) async {
    final Uri uri = Uri.https(baseUrl, 'api/v2/pokemon/$pokemonId');
    try {
      final Response<dynamic> response = await client.getUri(uri);
      final Map<String, dynamic> json = response.data;
      return PokemonDetailsEntity.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }
}
