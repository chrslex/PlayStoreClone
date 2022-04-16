import 'dart:async';
import 'package:gerbang_app/model/appModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/bookModel.dart';

var databasesPath = getDatabasesPath();

class InstalledBooksAndAppsDatabase {
  static final InstalledBooksAndAppsDatabase instance =
      InstalledBooksAndAppsDatabase.init();
  static Database? _database;
  InstalledBooksAndAppsDatabase.init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("InstalledBooksAndApps.db");
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);
    return await openDatabase(path,
        version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE IF NOT EXISTS InstalledBooks (
        ${InstalledBook.ID} $idType,
        ${InstalledBook.Title} $textType,
        ${InstalledBook.Cover} $textType,
        ${InstalledBook.ISBN} $textType,
        ${InstalledBook.Author} $textType,
        ${InstalledBook.Description} $textType,
        ${InstalledBook.DownloadCount} $integerType,
        ${InstalledBook.File} $textType,
        ${InstalledBook.Pending_status} $textType,
        ${InstalledBook.Publish_date} $textType,
        ${InstalledBook.Publisher} $textType,
        ${InstalledBook.Total_pages} $integerType,
        ${InstalledBook.Subcategories} $textType

      )
''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS InstalledApps (
        ${InstalledApp.ID} $idType,
        ${InstalledApp.Title} $textType,
        ${InstalledApp.Description} $textType,
        ${InstalledApp.Developer} $textType,
        ${InstalledApp.Age} $textType,
        ${InstalledApp.Size} $textType,
        ${InstalledApp.Icon} $textType,
        ${InstalledApp.File} $textType,
        ${InstalledApp.Pending_status} $textType,
        ${InstalledApp.DownloadCount} $integerType,
        ${InstalledApp.Subcategories} $textType
      )
''');
  }

  Future<Book> createBook(Book b) async {
    final db = await instance.database;

    final id =
        await db.insert("InstalledBooks", b.toJson());
    return b.copy(ID: id.toString());
  }

  Future<void> createApp(App a) async {
    final db = await instance.database;

    await db.insert("InstalledApps", a.toJson());
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<Book> readBook(String ID) async {
    final db = await instance.database;
    final maps = await db.query(
      "InstalledBooks",
      columns: [
        InstalledBook.ID,
        InstalledBook.Title,
        InstalledBook.Cover,
        InstalledBook.ISBN,
        InstalledBook.Author,
        InstalledBook.Cover,
        InstalledBook.DownloadCount,
        InstalledBook.File,
        InstalledBook.Pending_status,
        InstalledBook.Publisher,
        InstalledBook.Total_pages,
        InstalledBook.Subcategories,
        InstalledBook.Description
      ],
      where: '${InstalledBook.ID} = ?',
      whereArgs: [ID],
    );
    if (maps.isNotEmpty) {
      return Book.fromJson(maps.first);
    } else {
      throw Exception('ID $ID is not found');
    }
  }

  Future<List<Book>> readAllBook() async {
    final db = await instance.database;
    final result = await db.query("InstalledBooks");
    return result
        .map((json) => Book.fromJson(json))
        .toList();
  }

  Future<List<App>> readAllApps() async {
    final db = await instance.database;
    final result = await db.query("InstalledApps");
    return result.map((json) => App.fromJson(json)).toList();
  }

  Future<int> deleteBook(String id) async {
    final db = await instance.database;

    final result = await db.rawDelete(
        "DELETE FROM InstalledBooks WHERE ${InstalledBook.ID} = ?",
        [id]);
    return result;
  }

  Future<int> deleteApp(String id) async {
    final db = await instance.database;

    final result = await db.rawDelete("DELETE FROM InstalledApps WHERE ${InstalledApp.ID} = ?", [id]);
    return result;
  }

  Future<bool> checkBookExist(String id) async {
    final db = await instance.database;
    final result = await db.rawQuery(
        "SELECT * FROM InstalledBooks WHERE ${InstalledBook.ID} = ?",
        [id]);
    return result.isNotEmpty;
  }

  Future<bool> checkAppExist(String id) async {
    final db = await instance.database;
    final result = await db.rawQuery(
      "SELECT * FROM InstalledApps WHERE ${InstalledApp.ID} = ?",
      [id]);
    return result.isNotEmpty;
  }
}
