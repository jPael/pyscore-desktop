import 'package:path/path.dart';
import 'package:pyscore/models/user.dart';
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

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    const String idType = "TEXT PRIMARY KEY";

    const sql = '''
          CREATE TABLE $userTableName (
          id $idType,
          studentId Text UNIQUE ,
          username TEXT UNIQUE,
          password TEXT,
          firstname TEXT,
          lastname TEXT,
          user_type TEXT,
          createdAt TEXT,
          updatedAt TEXT
          )
''';

    await db.execute(sql);
  }
}
