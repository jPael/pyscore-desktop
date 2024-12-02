import 'package:pyscore/fields/post_fields.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/services/db.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<List<Post>> getPostsByClassId(String id) async {
  final Database db = await Db.instance.db;

  final result = await db.query(postTableName,
      where: "${PostFields.classId} = ?", whereArgs: [id]);

  if (result.isEmpty) return [];

  List<Post> classedPost =
      await Future.wait(result.map((r) => Post.fromJson(r)).toList());

  return classedPost;
}
