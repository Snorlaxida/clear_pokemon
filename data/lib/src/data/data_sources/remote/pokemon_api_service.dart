import 'package:core/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import '../../entity/poke_page/poke_page_from_api_entity.dart';
import '../../entity/pokemon_details/pokemon_details_from_api_entity.dart';
import '../../entity/pokemon_details/pokemon_details_from_db_entity.dart';
import '../local/pokemon_db_service.dart';

class PokemonApiService {
  final Dio client;
  final DatabaseService databaseService;

  PokemonApiService({
    required this.databaseService,
    required this.client,
  });

  Future<PokePageFromApiEntity> getPokemonPage({int startWith = 0}) async {
    final Map<String, String> queryParameters = <String, String>{
      'limit': '20',
      'offset': startWith.toString(),
    };
    final Uri uri = Uri.https(baseUrl, 'api/v2/pokemon', queryParameters);
    final Response<dynamic> response = await client.getUri(uri);
    final Map<String, dynamic> json = response.data;

    return PokePageFromApiEntity.fromJson(json);
  }

  Future<PokemonDetailsFromApiEntity> getPokemonDetails(int pokemonId) async {
    final Uri uri = Uri.https(baseUrl, 'api/v2/pokemon/$pokemonId');
    final PokemonDetailsFromDbEntity? pokemonDetail =
        await databaseService.getPokemonDetails(pokemonId);
    if (pokemonDetail != null) {
      return pokemonDetail;
    }
    try {
      final Response<dynamic> response = await client.getUri(uri);
      final Map<String, dynamic> json = response.data;
      await databaseService.addPokemon(PokemonDetailsModel.fromJson(json));
      return PokemonDetailsModel.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }
}
