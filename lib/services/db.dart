import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  static final Db instance = Db._instance();
  static Database? _database;

  Db._instance();

  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'pyscoredb.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    const sql = '''
          CREATE TABLE users (
          id TEXT PRIMARY KEY,
          username TEXT UNIQUE,
          passwrod TEXT,
          firstname TEXT,
          lastname TEXT,
          user_type TEXT
          createdAt TEXT,
          updatedAt TEXT
          )
''';

// TODO: finish the database later

    await db.execute(sql);
  }
}
