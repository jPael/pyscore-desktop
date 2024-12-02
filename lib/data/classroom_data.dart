import 'package:pyscore/fields/classroom_fields.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/models/user.dart';
import 'package:pyscore/services/db.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<Classroom?> getClassroomById(String id) async {
  final Database db = await Db.instance.db;

  final row =
      await db.query(classroomTableName, where: "id = ?", whereArgs: [id]);

  if (row.isEmpty) return null;

  return Classroom.fromJson(row[0]);
}

Future<User> getClassroomOwnerById(String id) async {
  final Database db = await Db.instance.db;

  final row = await db.query(userTableName, where: "id = ?", whereArgs: [id]);

  return User.fromJson(row[0]);
}

Future<List<Classroom>> getAllUsersClassroomById(String id) async {
  final Database db = await Db.instance.db;

  final rows =
      await db.query(classroomTableName, where: "owner = ?", whereArgs: [id]);

  return await Future.wait(rows.map((r) async => await Classroom.fromJson(r)));
}

Future<List<Classroom>> getAllClassroomByOwnerId(String id) async {
  final Database db = await Db.instance.db;

  final rows = await db.query(classroomTableName,
      where: "${ClassroomFields.ownerId} = ?", whereArgs: [id]);

  return await Future.wait(rows.map((r) async => await Classroom.fromJson(r)));
}
