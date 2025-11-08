import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static const _dbName = 'tasks.db';
  static const _dbVersion = 1;
  static const table = 'tasks';

  static Future<Database> _open() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, v) async {
        await db.execute('''
        CREATE TABLE tasks(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          description TEXT,
          isCompleted INTEGER NOT NULL DEFAULT 0
        )
      ''');
      },
    );
  }

  static Future<int> insert(Map<String, dynamic> task) async {
    final db = await _open();
    return db.insert(table, task);
  }

  static Future<List<Map<String, dynamic>>> getAll() async {
    final db = await _open();
    return db.query(table, orderBy: 'id DESC');
  }

  static Future<int> update(int id, Map<String, dynamic> data) async {
    final db = await _open();
    return db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> delete(int id) async {
    final db = await _open();
    return db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
