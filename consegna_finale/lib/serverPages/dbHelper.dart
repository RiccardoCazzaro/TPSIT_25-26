import "package:sqflite/sqflite.dart";
import "package:path/path.dart";

class DBService {
  static Database? _db;

  static Future<Database> getDb() async {
    _db ??= await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), "futsal.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("""
          CREATE TABLE players (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            number INTEGER,
            foot TEXT,
            team TEXT,
            is_syncronized INTEGER DEFAULT 0
          )
        """);
        await db.execute("""
          CREATE TABLE matches (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            opponent TEXT,
            date TEXT,
            goals_for INTEGER,
            goals_against INTEGER,
            league_position INTEGER,
            is_syncronized INTEGER DEFAULT 0
          )
        """);
      },
    );
  }

  //PLAYERS

  static Future<void> clearPlayers() async {
    (await getDb()).delete("players");
  }

  static Future<void> insertPlayer(Map<String, dynamic> data) async {
    (await getDb()).insert("players", data);
  }

  static Future<List<Map<String, dynamic>>> getPlayers() async {
    return (await getDb()).query("players");
  }

  static Future<void> updatePlayer(int id, Map<String, dynamic> data) async {
    (await getDb()).update("players", data, where: "id=?", whereArgs: [id]);
  }

  static Future<void> patchPlayer(int id, Map<String, dynamic> data) async {
    (await getDb()).update("players", data, where: "id=?", whereArgs: [id]);
  }

  static Future<void> deletePlayer(int id) async {
    (await getDb()).delete("players", where: "id=?", whereArgs: [id]);
  }

  // MATCHES 

  static Future<void> clearMatches() async {
    (await getDb()).delete("matches");
  }

  static Future<void> insertMatch(Map<String, dynamic> data) async {
    (await getDb()).insert("matches", data);
  }

  static Future<List<Map<String, dynamic>>> getMatches() async {
    return (await getDb()).query("matches");
  }

  static Future<void> updateMatch(int id, Map<String, dynamic> data) async {
    (await getDb()).update("matches", data, where: "id=?", whereArgs: [id]);
  }

  static Future<void> patchMatch(int id, Map<String, dynamic> fields) async {
    (await getDb()).update("matches", fields, where: "id=?", whereArgs: [id]);
  }

  static Future<void> deleteMatch(int id) async {
    (await getDb()).delete("matches", where: "id=?", whereArgs: [id]);
  }
}
