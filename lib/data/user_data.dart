import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/models/user.dart';
import 'package:pyscore/services/db.dart';

Future<User?> getUserByUsername(String username) async {
  final db = await Db.instance.db;
  final result = await db
      .query(userTableName, where: "username = ?", whereArgs: [username]);

  // print(result.length);
  // for (var r in result) {
  //   print(r['id']);
  //   print(r['password']);
  // }

  if (result.isEmpty) return null;

  return User.fromJson(result[0]);
}

Future<User?> getUserById(String id) async {
  final db = await Db.instance.db;

  final result =
      await db.query(userTableName, where: "id = ?", whereArgs: [id]);

  if (result.isEmpty) return null;

  return User.fromJson(result[0]);
}

Future<List<User>?> getAllUser() async {
  final db = await Db.instance.db;
  final result = await db.query(userTableName);

  if (result.isEmpty) return null;

  return result.map((json) => User.fromJson(json)).toList();
}
