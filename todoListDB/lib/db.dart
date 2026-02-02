import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model.dart';

class DatabaseHelper {
  static Future<Database> init() async {
    String path = join(await getDatabasesPath(), 'todo_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL)');
        await db.execute('''
          CREATE TABLE todos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            note_id INTEGER NOT NULL,
            name TEXT NOT NULL,
            checked INTEGER NOT NULL,
            FOREIGN KEY (note_id) REFERENCES notes (id) ON DELETE CASCADE
          )''');
      },
    );
  }

  static Future<int> insertNote(String title) async {
    final db = await init();
    return await db.insert('notes', {'title': title});
  }

  static Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await init();
    return await db.query('notes');
  }

  static Future<void> deleteNote(int id) async {
    final db = await init();
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Todo>> getTodosForNote(int noteId) async {
    final db = await init();
    final List<Map<String, dynamic>> result =
        await db.query('todos', where: 'note_id = ?', whereArgs: [noteId]);
    return result.map((row) => Todo.fromMap(row)).toList();
  }

  static Future<void> insertTodo(Todo todo, int noteId) async {
    final db = await init();
    Map<String, dynamic> data = todo.toMap();
    data['note_id'] = noteId;
    await db.insert('todos', data);
  }

  static Future<void> updateTodo(Todo todo) async {
    final db = await init();
    await db
        .update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  static Future<void> deleteTodo(int id) async {
    final db = await init();
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
