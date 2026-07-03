import 'package:sqflite/sqflite.dart';
import '../model/NewsArticleModel.dart';
import 'DatabaseProvider.dart';

class LocalStorageDao {
  static final LocalStorageDao instance = LocalStorageDao._init();

  LocalStorageDao._init();
  Future<int> insertBookmark(Articles article) async {
    final db = await DatabaseProvider.instance.database;

    return await db.insert(
      'bookmarks',
      {
        'title': article.title,
        'author': article.author,
        'description': article.description,
        'content': article.content,
        'url': article.url,
        'urlToImage': article.urlToImage,
        'publishedAt': article.publishedAt,
        'sourceName': article.source?.name,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<Articles>> getBookmarks() async {
    final db = await DatabaseProvider.instance.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'bookmarks',
      orderBy: 'id DESC',
    );

    return maps.map((map) {
      return Articles(
        title: map['title'],
        author: map['author'],
        description: map['description'],
        content: map['content'],
        url: map['url'],
        urlToImage: map['urlToImage'],
        publishedAt: map['publishedAt'],
        source: map['sourceName'] != null ? Source(name: map['sourceName']) : null,
      );
    }).toList();
  }

  Future<int> deleteBookmark(String url) async {
    final db = await DatabaseProvider.instance.database;

    return await db.delete(
      'bookmarks',
      where: 'url = ?',
      whereArgs: [url],
    );
  }

  Future<bool> isBookmarked(String url) async {
    final db = await DatabaseProvider.instance.database;

    final result = await db.query(
      'bookmarks',
      where: 'url = ?',
      whereArgs: [url],
    );

    return result.isNotEmpty;
  }
}