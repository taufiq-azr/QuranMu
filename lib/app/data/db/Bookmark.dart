import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseManager {
  DatabaseManager._privateConstructor();

  static final DatabaseManager instance = DatabaseManager._privateConstructor();

  Database? _database;

  Future<Database> get db async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "bookmark.db");

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bookmark (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        surah TEXT NOT NULL,
        number_surah INTEGER NOT NULL,
        ayat INTEGER NOT NULL,
        via TEXT NOT NULL,
        index_ayat INTEGER NOT NULL,
        last_read INTEGER DEFAULT 0
      );
    ''');
  }

  Future<void> closeDB() async {
    await _database?.close();
  }
}
