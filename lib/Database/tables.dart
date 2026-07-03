import 'package:sqflite/sqflite.dart';

class BookmarkTable {
  static const String tableName = "bookmarks";

  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        author TEXT,
        description TEXT,
        content TEXT,
        url TEXT UNIQUE,
        urlToImage TEXT,
        publishedAt TEXT,
        sourceName TEXT
      )
    ''');
  }
}