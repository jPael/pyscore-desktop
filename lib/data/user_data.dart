import 'package:pyscore/constants/types/user_type.dart';
import 'package:pyscore/fields/user_fields.dart';
import 'package:pyscore/models/user.dart';
import 'package:pyscore/services/db.dart';

Future<User?> getUserByUsername(String username) async {
  final db = await Db.instance.db;
  final result = await db.query(userTableName,
      where: "${UserFields.username} = ? AND ${UserFields.userType} = ?",
      whereArgs: [username, UserType.teacher]);

  // print(result.length);
  // for (var r in result) {
  //   print(r['id']);
  //   print(r['password']);
  // }

  if (result.isEmpty) return null;

  return User.fromJson(result[0]);
}

Future<User?> getStudentByStudentId(String studentId) async {
  final db = await Db.instance.db;
  final result = await db.query(userTableName,
      where: "${UserFields.studentId} = ? AND ${UserFields.userType} = ?",
      whereArgs: [studentId, UserType.student]);

  if (result.isEmpty) {
    return null;
  }

  return User.fromJson(result[0]);
}

Future<User?> getUserByUsernameAndType(String username, String type) async {
  final db = await Db.instance.db;
  final result = await db
      .query(userTableName, where: "username = ? AND user_type = ?", whereArgs: [username, type]);

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

  final result = await db.query(userTableName, where: "id = ?", whereArgs: [id]);

  if (result.isEmpty) return null;

  return User.fromJson(result[0]);
}

Future<List<User>?> getAllUser() async {
  final db = await Db.instance.db;
  final result = await db.query(userTableName);

  if (result.isEmpty) return null;

  return result.map((json) => User.fromJson(json)).toList();
}
