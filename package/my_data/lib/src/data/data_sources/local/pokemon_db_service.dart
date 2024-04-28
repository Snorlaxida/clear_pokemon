import 'package:my_data/src/data/model/poke_list_part_model.dart';
import 'package:my_data/src/data/model/pokemon_details_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static const int version = 1;
  static const String dbName = 'Pokemons.db';

  static Future<Database> _getDb() async {
    return openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: (db, version) async {
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

  static Future<int> addPokemon(PokemonDetailsModel pokemonDetails) async {
    final db = await _getDb();
    return await db.insert("pokemon", pokemonDetails.toJson());
  }

  static Future<int> addPokemonListPart(PokeListPartModel pokeListPart) async {
    final db = await _getDb();
    return await db.insert("pokemon", pokeListPart.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updatePokemon(PokemonDetailsModel pokemonDetails) async {
    final db = await _getDb();
    return await db.update(
      "pokemon",
      pokemonDetails.toJson(),
      where: 'id = ?',
      whereArgs: [pokemonDetails.pokemonId],
    );
  }

  static Future<int> deletePokemon(PokemonDetailsModel pokemonDetails) async {
    final db = await _getDb();
    return await db.delete(
      "pokemon",
      where: 'id = ?',
      whereArgs: [pokemonDetails.pokemonId],
    );
  }

  static Future<int> deleteAllPokemons() async {
    final db = await _getDb();
    return await db.delete(
      "pokemon",
    );
  }

  static Future<List<PokemonDetailsModel>?> getAllPokemons() async {
    final db = await _getDb();

    final List<Map<String, dynamic>> maps = await db.query('pokemon');
    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => PokemonDetailsModel.fromDbJson(maps[index]));
  }

  static Future<PokemonDetailsModel?> getPokemonDetails(int id) async {
    final db = await _getDb();

    final List<Map<String, dynamic>> pokemonDetailsJson = await db.query(
      'pokemon',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (pokemonDetailsJson.isEmpty ||
        PokemonDetailsModel.fromDbJson(pokemonDetailsJson[0]).image == null) {
      return null;
    }

    return PokemonDetailsModel.fromDbJson(pokemonDetailsJson[0]);
  }

  Future<List<PokeListPartModel>?> getAllPokeListParts() async {
    final db = await _getDb();

    final List<Map<String, dynamic>> maps = await db.query('pokemon');
    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => PokeListPartModel.fromDbJson(maps[index]));
  }
}
