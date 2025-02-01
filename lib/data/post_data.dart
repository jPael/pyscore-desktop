import 'package:pyscore/constants/errors/post_errors.dart';
import 'package:pyscore/fields/post_fields.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/services/db.dart';
import 'package:pyscore/utils/results.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<List<Post>> getAllPostsByClassId(String id) async {
  final Database db = await Db.instance.db;

  final result = await db.query(postTableName, where: "${PostFields.classId} = ?", whereArgs: [id]);

  if (result.isEmpty) return [];

  List<Post> classedPost = await Future.wait(result.map((r) => Post.fromJson(r)).toList());

  return classedPost;
}

Future<Post?> getPostById(String id) async {
  final Database db = await Db.instance.db;

  final result = await db.query(postTableName, where: "${PostFields.id} = ?", whereArgs: [id]);

  if (result.isEmpty) return null;

  Post post = await Post.fromJson(result[0]);

  return post;
}

Future<PostResults> deletePostById(String postId) async {
  final Database db = await Db.instance.db;

  final result = await db.delete(
    postTableName,
    where: "id = ?",
    whereArgs: [postId],
  );

  if (result == 0) {
    return PostResults(success: false, error: PostErrorCode.postDeletionFailed);
  }

  return PostResults(success: true);
}
