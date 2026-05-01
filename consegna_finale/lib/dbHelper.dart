import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
      onCreate: (db, _) async {
        await db.execute("""
        CREATE TABLE players (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT, number INTEGER,
          is_syncronized INTEGER DEFAULT 0
        )
      """);
        await db.execute("""
        CREATE TABLE matches (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          opponent TEXT, date TEXT,
          goals_for INTEGER, goals_against INTEGER,
          is_syncronized INTEGER DEFAULT 0
        )
      """);
      },
    );
  }
}
