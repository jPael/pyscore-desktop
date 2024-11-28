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

  return User.fromJson(result[0]);
}

Future<List<User>> getAllUser() async {
  final db = await Db.instance.db;
  final result = await db.query(userTableName);
  return result.map((json) => User.fromJson(json)).toList();
}
