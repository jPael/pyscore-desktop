import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pyscore/services/db_tables.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  static final Db instance = Db._instance();
  static Database? _database;
  static String databaseFilename = 'pyscoredb.db';
  static bool flagRefreshDb = false;

  Db._instance();
  Db();

  Future<Database> get db async {
    _database ??= await initDb();

    return _database!;
  }

  Future<Database> initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseFilename);

    if (flagRefreshDb) {
      if (await databaseExists(path)) {
        await deleteDatabase(path);
      }
      flagRefreshDb = false;
    }

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    List<Map<String, String>> queries = sqlTables;

    for (Map<String, String> query in queries) {
      final bool isTableExists = await _isTableExists(db, query["tablename"]!);

      if (isTableExists) continue;
      print(query["query"]!);
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

  Future<void> downloadDb() async {
    try {
      // Get the Downloads directory path
      Directory? downloadsDirectory = await getExternalStorageDirectory();
      if (downloadsDirectory == null) {
        print("Downloads directory not found");
        return;
      }

      // Get the database path
      String databasePath = await getDatabasesPath();
      String path = join(databasePath, databaseFilename);

      // Check if the database file exists
      File databaseFile = File(path);
      bool hasExisted = await databaseFile.exists();
      if (!hasExisted) {
        print("Database file does not exist: $path");
        return;
      }

      // Define the destination path in the Downloads directory
      String destinationPath = join(downloadsDirectory.path, databaseFilename);

      // Copy the database file to the Downloads directory
      await databaseFile.copy(destinationPath);

      print("Database file copied to: $destinationPath");
    } catch (e) {
      print("Error occurred: $e");
    }
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
