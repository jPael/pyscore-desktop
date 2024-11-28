import 'package:pyscore/fields/user_fields.dart';
import 'package:pyscore/services/db.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:uuid/uuid.dart';
import 'package:crypt/crypt.dart';

const String userTableName = "User";

class User {
  String? id;
  final String firstname;
  final String lastname;
  final String studentId;
  final String? password;
  final String userType;
  final String username;
  String? createdAt;
  String? updatedAt;
  String? hashedPassword;

  User({
    required this.firstname,
    required this.lastname,
    required this.studentId,
    this.password,
    required this.userType,
    this.id,
    required this.username,
  });

  Map<String, dynamic> get getUserInfo => {
        "firstname": firstname,
        "lastname": lastname,
        "studentId": studentId,
        "userType": userType
      };

  static User fromJson(Map<String, Object?> json) => User(
      id: json['id'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      studentId: json['studentId'] as String,
      userType: json['user_type'] as String,
      username: json["username"] as String,
      password: json["password"] as String);

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.firstname: firstname,
        UserFields.lastname: lastname,
        UserFields.studentId: studentId,
        UserFields.password: hashedPassword,
        UserFields.userType: userType,
        UserFields.username: username,
        UserFields.createdAt: createdAt,
        UserFields.updatedAt: updatedAt,
      };

  Future<void> insertToDb() async {
    const Uuid uuid = Uuid();

    final Database db = await Db.instance.db;
    final String userId = uuid.v4();
    hashedPassword = Crypt.sha256(password!).toString();

    id = userId;
    createdAt = DateTime.now().toString();
    updatedAt = DateTime.now().toString();

    await db.insert(userTableName, toJson());
  }
}

class UserType {
  static String get teacher => "TEACHER";
  static String get student => "STUDENT";
}
