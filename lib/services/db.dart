import 'dart:io';

import 'package:path/path.dart';
import 'package:pyscore/services/db_tables.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  static final Db instance = Db._instance();
  static Database? _database;
  static String databaseFilename = 'pyscoredb.db';

  Db._instance();
  Db();

  Future<Database> get db async {
    _database ??= await initDb();

    return _database!;
  }

  Future<Database> initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseFilename);

    print("db path: " + path);

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    List<Map<String, String>> queries = sqlTables;

    for (Map<String, String> query in queries) {
      final bool isTableExists = await _isTableExists(db, query["tablename"]!);

      if (isTableExists) continue;
      await db.execute(query["query"]!);
    }
  }

  Future<void> replaceDb(String? fileDirectory) async {
    if (fileDirectory == null) return;

    String databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseFilename);

    File newFile = File(fileDirectory);

    await newFile.copy(path);
    _database = await openDatabase(path);

    print("Db replaced successfully");
  }

  Future<bool> _isTableExists(Database db, String tablename) async {
    const query = '''
    SELECT name 
    FROM sqlite_master
    WHERE type='table' AND name=?
  ''';

    final result = await db.rawQuery(query, [tablename]);

    return result.isNotEmpty;
  }
}
