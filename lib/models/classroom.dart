import 'package:pyscore/constants/classroom_errors.dart';
import 'package:pyscore/data/user_data.dart';
import 'package:pyscore/fields/classroom_fields.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/models/user.dart';
import 'package:pyscore/services/db.dart';
import 'package:pyscore/utils/results.dart';
import 'package:random_string_generator/random_string_generator.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:uuid/uuid.dart';

const String classroomTableName = "Classroom";

class Classroom {
  final String classroomName;
  final User owner;
  final List<Post>? posts;
  String? createdAt;
  String? updatedAt;
  String? id;
  String? code;

  Classroom(
      {this.id,
      required this.classroomName,
      required this.owner,
      this.posts = const [],
      this.createdAt,
      this.updatedAt,
      this.code});

  Classroom copyWith({
    String? classroomName,
    User? owner,
    List<Post>? posts,
    String? createdAt,
    String? updatedAt,
    String? id,
    String? code,
  }) =>
      Classroom(
          classroomName: classroomName ?? this.classroomName,
          owner: owner ?? this.owner,
          code: code ?? this.code,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt,
          id: id ?? this.id,
          posts: posts ?? this.posts);

  Map<String, Object?> toJson() => {
        ClassroomFields.id: id,
        ClassroomFields.name: classroomName,
        ClassroomFields.ownerId: owner.id,
        ClassroomFields.code: code!,
        ClassroomFields.createdAt: createdAt!,
        ClassroomFields.updatedAt: updatedAt!,
      };

  static Future<Classroom> fromJson(Map<String, Object?> json) async {
    final String userId = json[ClassroomFields.ownerId] as String;

    final User? owner = await getUserById(userId);

    Classroom classroom = Classroom(
        classroomName: json[ClassroomFields.name] as String,
        owner: owner!,
        createdAt: json[ClassroomFields.createdAt] as String,
        updatedAt: json[ClassroomFields.updatedAt] as String,
        id: json[ClassroomFields.id] as String,
        code: json[ClassroomFields.code] as String);

    return classroom;
  }

  Future<ClassroomResults> insertToDb(String ownderId) async {
    const Uuid uuid = Uuid();

    final Database db = await Db.instance.db;
    final classroomId = uuid.v4();

    id = classroomId;
    createdAt = DateTime.now().toString();
    updatedAt = DateTime.now().toString();
    RandomStringGenerator codeGenerator = RandomStringGenerator(
        fixedLength: 5, hasAlpha: false, hasDigits: true, hasSymbols: false);
    code = codeGenerator.generate();

    try {
      int resultRow = await db.insert(classroomTableName, toJson());

      if (resultRow > 0) {
        return ClassroomResults(success: true);
      } else {
        throw Error();
      }
    } catch (e) {
      print(e);
      return ClassroomResults(
          code: ClassroomErrorCode.creationError, success: false);
    }
  }
}
