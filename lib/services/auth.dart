import 'package:flutter/foundation.dart';
import 'package:pyscore/constants/auth_errors.dart';
import 'package:pyscore/constants/user_type.dart';
import 'package:pyscore/services/auth_helper.dart';
import 'package:pyscore/utils/results.dart';

Future<AuthResults> signIn(String username, String password, String type) async {
  try {
    if (type == UserType.teacher) {
      return await signinAsTeacher(username, password);
    } else if (type == UserType.student) {
      return await signinAsStudent(username, password);
    } else {
      return AuthResults(success: false, error: AuthErrorCode.unspecifiedUserType);
    }
  } catch (e) {
    // ignore: avoid_print
    print(e);
    return AuthResults(success: false, error: AuthErrorCode.serverError);
  }
}

Future<AuthResults> signUp(String type, Map<String, Object?> data) async {
  try {
    if (type == UserType.teacher) {
      return await signupAsTeacher(data);
    } else {
      // TODO: finish the registration of student of student maligo sa ko

      return await signupAsStudent(data);
    }
  } on Exception catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return AuthResults(success: false, error: AuthErrorCode.serverError);
  }
}
