const int version = 1;
const String dbName = 'Pokemons.db';
const String baseUrl = 'pokeapi.co';
const String createDb = '''
          CREATE TABLE "pokemon" (
            "id"	INTEGER UNIQUE,
            "name"	TEXT,
            "types"	TEXT,
            "image"	TEXT,
            "height"	INTEGER,
            "weight"	INTEGER,
            PRIMARY KEY("id")
          );
          ''';
