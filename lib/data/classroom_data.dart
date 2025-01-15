import 'package:pyscore/data/user_data.dart';
import 'package:pyscore/fields/classroom_fields.dart';
import 'package:pyscore/fields/user_classroom_fields.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/models/user.dart';
import 'package:pyscore/services/db.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<Classroom?> getClassroomById(String id) async {
  final Database db = await Db.instance.db;

  final row = await db.query(classroomTableName, where: "id = ?", whereArgs: [id]);

  if (row.isEmpty) return null;

  return Classroom.fromJson(row[0]);
}

Future<User> getClassroomOwnerById(String id) async {
  final Database db = await Db.instance.db;

  final row = await db.query(userTableName, where: "id = ?", whereArgs: [id]);

  return User.fromJson(row[0]);
}

Future<List<Classroom>> getAllUsersClassroomByUserId(String id) async {
  final Database db = await Db.instance.db;

  final rows = await db.query(classroomTableName, where: "owner = ?", whereArgs: [id]);

  // Wait for all the futures to resolve
  final results = await Future.wait(rows.map((r) async => await Classroom.fromJson(r)));

  // Filter out null values after all futures are resolved
  return results.whereType<Classroom>().toList();
}

Future<List<Classroom?>> getAllClassroomAsTeacher(String id) async {
  final Database db = await Db.instance.db;
  final rows =
      await db.query(classroomTableName, where: "${ClassroomFields.ownerId} = ?", whereArgs: [id]);

  return await Future.wait(rows.map((r) async => await Classroom.fromJson(r)));
}

Future<List<Classroom?>> getAllClassroomAsStudent(String id) async {
  final Database db = await Db.instance.db;

  final classroomIds = await db.query(userClassroomTableName,
      columns: [UserClassroomFields.classroomId],
      where: "${UserClassroomFields.userId} = ?",
      whereArgs: [id]);

  return await Future.wait(classroomIds.map((cId) async {
    final String classroomId = cId[UserClassroomFields.classroomId] as String;
    Classroom? classroom = await getClassroomById(classroomId);

    if (classroom == null) {
      return null;
    }

    return classroom;
  }).toList());
}

Future<Classroom?> getClassroomByCode(String code) async {
  final Database db = await Db.instance.db;

  final row = await db.query(classroomTableName, where: "code = ?", whereArgs: [code]);

  if (row.isEmpty) {
    return null;
  }

  return Classroom.fromJson(row[0]);
}

Future<bool> joinClassroom(String userId, String classroomId) async {
  final Database db = await Db.instance.db;

  String createdAt = DateTime.now().toString();
  String updateAt = DateTime.now().toString();

  Map<String, Object?> values = {
    UserClassroomFields.classroomId: classroomId,
    UserClassroomFields.userId: userId,
    UserClassroomFields.createdAt: createdAt,
    UserClassroomFields.updatedAt: updateAt
  };

  final row = await db.insert(userClassroomTableName, values);

  if (row == 0) {
    return false;
  }

  return true;
}

Future<List<User>> getAllClassroomMember(String id) async {
  final Database db = await Db.instance.db;

  final userIds = await db.query(userClassroomTableName,
      columns: [UserClassroomFields.userId],
      where: "${UserClassroomFields.classroomId} = ?",
      whereArgs: [id]);

  final List<User?> _users = await Future.wait(userIds.map((user) async {
    final String id = user[UserClassroomFields.userId] as String;
    final userRow = await getUserById(id);
    return userRow;
  }));

  _users.sort((a, b) {
    if (a == null && b == null) return 0;
    if (a == null) return 1;
    if (b == null) return -1;
    return a.firstname.compareTo(b.firstname);
  });

  return _users.where((u) => u != null).cast<User>().toList();
}

Future<void> deleteClassroomById(String id) async {
  final Database db = await Db.instance.db;

  await db.delete(classroomTableName, where: "id = ?", whereArgs: [id]);
}
