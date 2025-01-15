import 'package:flutter/foundation.dart';
import 'package:pyscore/constants/auth_errors.dart';
import 'package:pyscore/fields/user_fields.dart';
import 'package:pyscore/services/auth.dart' as auth;
import 'package:pyscore/services/db.dart';
import 'package:pyscore/utils/results.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:uuid/uuid.dart';
import 'package:crypt/crypt.dart';

const String userTableName = "User";

class User {
  String? id;
  final String firstname;
  final String lastname;
  final String studentId;
  final String userType;
  final String username;
  final String? password;
  final String? section;
  String? createdAt;
  String? updatedAt;
  String? hashedPassword;

  User(
      {required this.firstname,
      required this.lastname,
      required this.studentId,
      required this.userType,
      required this.username,
      this.password,
      this.id,
      this.section,
      this.createdAt,
      this.updatedAt});

  Map<String, dynamic> get getUserInfo => {
        "id": id!,
        "firstname": firstname,
        "lastname": lastname,
        "studentId": studentId,
        "userType": userType
      };

  static User fromJson(Map<String, Object?> json) => User(
        id: json['id'] as String,
        firstname: json[UserFields.firstname] as String,
        lastname: json[UserFields.lastname] as String,
        studentId: json[UserFields.studentId] as String,
        section: json[UserFields.section] as String,
        userType: json[UserFields.userType] as String,
        username: json[UserFields.username] as String,
        password: json[UserFields.password] as String? ?? "",
        createdAt: json[UserFields.createdAt] as String,
        updatedAt: json[UserFields.updatedAt] as String,
      );

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.firstname: firstname,
        UserFields.lastname: lastname,
        UserFields.studentId: studentId,
        UserFields.password: hashedPassword,
        UserFields.userType: userType,
        UserFields.username: username,
        UserFields.section: section ?? "",
        UserFields.createdAt: createdAt ?? "",
        UserFields.updatedAt: updatedAt ?? "",
      };

  Future<void> signUp() async {
    const Uuid uuid = Uuid();

    final String userId = uuid.v4();
    hashedPassword = Crypt.sha256(password!).toString();

    id = userId;
    createdAt = DateTime.now().toString();
    updatedAt = DateTime.now().toString();

    final AuthResults res = await auth.signUp(userType, toJson());

    if (!res.isSuccess) {
      if (kDebugMode) {
        print(Autherrors.error(res.error!));
      }
    } else {
      if (kDebugMode) {
        print("Success");
      }
    }

    // await db.insert(userTableName, toJson());
  }
}
