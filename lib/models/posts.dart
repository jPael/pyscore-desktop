import 'package:pyscore/constants/post_errors.dart';
import 'package:pyscore/data/classroom_data.dart';
import 'package:pyscore/fields/post_fields.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/services/db.dart';
import 'package:pyscore/utils/results.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:uuid/uuid.dart';

const String postTableName = "Post";

class Post {
  String? id;
  final String title;
  final String instruction;
  final int points;
  final String due;
  Classroom? classroom;
  String? classroomId;
  int duration;
  String? createdAt;
  String? updatedAt;

  Post(
      {this.classroom,
      this.classroomId,
      required this.duration,
      this.id,
      required this.title,
      required this.instruction,
      required this.points,
      required this.due,
      this.createdAt,
      this.updatedAt});

  static Future<Post> fromJson(Map<String, Object?> json) async {
    Classroom? _classroom =
        await getClassroomById(json[PostFields.classId] as String);

    Post post = Post(
        id: json[PostFields.id] as String,
        title: json[PostFields.title] as String,
        instruction: json[PostFields.instruction] as String,
        points: int.parse(json[PostFields.points] as String),
        duration: int.parse(json[PostFields.duration] as String),
        due: json[PostFields.due] as String,
        createdAt: json[PostFields.createdAt] as String,
        updatedAt: json[PostFields.updatedAt] as String,
        classroom: _classroom!);

    return post;
  }

  Map<String, Object?> toJson() => {
        PostFields.id: id,
        PostFields.title: title,
        PostFields.instruction: instruction,
        PostFields.points: points.toString(),
        PostFields.createdAt: createdAt,
        PostFields.updatedAt: updatedAt,
        PostFields.duration: duration.toString(),
        PostFields.due: due,
        PostFields.classId: classroomId
      };

  Future<PostResults> insertToDb() async {
    const Uuid uuid = Uuid();
    final Database db = await Db.instance.db;

    final String postId = uuid.v4();
    final String postCreatedAt = DateTime.now().toString();
    final String postUpdatedAt = DateTime.now().toString();

    id = postId;
    createdAt = postCreatedAt;
    updatedAt = postUpdatedAt;

    try {
      int insertId = await db.insert(postTableName, toJson());

      if (insertId > 0) {
        return PostResults(
            success: false, code: PostErrorCode.postCreationError);
      }

      return PostResults(success: true);
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);

      return PostResults(success: false, code: PostErrorCode.serverError);
    }
  }
}
