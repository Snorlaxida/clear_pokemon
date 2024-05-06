import 'package:core/constants/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../entity/poke_list_part/poke_list_part_from_db_entity.dart';
import '../../entity/pokemon_details/pokemon_details_from_db_entity.dart';

class DatabaseService {
  final Database database;

  DatabaseService({required this.database});

  static Future<Database> getDb() async {
    return openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: (Database db, int version) async {
        await db.execute(createDb);
      },
      version: version,
    );
  }

  Future<int> addPokemon(PokemonDetailsFromDbEntity pokemonDetails) async {
    return database.insert('pokemon', pokemonDetails.toJson());
  }

  Future<PokemonDetailsFromDbEntity?> getPokemonDetails(int id) async {
    final List<Map<String, dynamic>> pokemonDetailsJson = await database.query(
      'pokemon',
      where: 'id = ?',
      whereArgs: <Object?>[id],
    );
    if (pokemonDetailsJson.isEmpty) {
      return null;
    }

    return PokemonDetailsFromDbEntity.fromJson(pokemonDetailsJson[0]);
  }

  Future<List<PokeListPartFromDbEntity>?> getAllPokeListParts() async {
    final List<Map<String, dynamic>> maps = await database.query('pokemon');
    if (maps.isEmpty) {
      return null;
    }
    return maps
        .map(
          PokeListPartFromDbEntity.fromJson,
        )
        .toList();
  }
}
