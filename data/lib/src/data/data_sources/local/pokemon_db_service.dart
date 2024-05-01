import 'package:core/constants/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/poke_list_part_model.dart';
import '../../model/pokemon_details_model.dart';

class DatabaseService {
  final Database database;

  DatabaseService({required this.database});

  static Future<Database> getDb() async {
    return openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE "pokemon" (
          "id"	INTEGER UNIQUE,
          "name"	TEXT,
          "types"	TEXT,
          "image"	BLOB,
          "height"	INTEGER,
          "weight"	INTEGER,
          PRIMARY KEY("id")
        );
        ''');
      },
      version: version,
    );
  }

  Future<int> addPokemon(PokemonDetailsModel pokemonDetails) async {
    return database.insert('pokemon', pokemonDetails.toJson());
  }

  Future<PokemonDetailsModel?> getPokemonDetails(int id) async {
    final List<Map<String, dynamic>> pokemonDetailsJson = await database.query(
      'pokemon',
      where: 'id = ?',
      whereArgs: <Object?>[id],
    );
    if (pokemonDetailsJson.isEmpty ||
        PokemonDetailsModel.fromDbJson(pokemonDetailsJson[0]).image == null) {
      return null;
    }

    return PokemonDetailsModel.fromDbJson(pokemonDetailsJson[0]);
  }

  Future<List<PokeListPartModel>?> getAllPokeListParts() async {
    final List<Map<String, dynamic>> maps = await database.query('pokemon');
    if (maps.isEmpty) {
      return null;
    }
    return maps.map(PokeListPartModel.fromDbJson).toList();
  }
}
