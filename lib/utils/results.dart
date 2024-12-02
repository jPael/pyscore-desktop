import 'package:pyscore/constants/auth_errors.dart';
import 'package:pyscore/constants/classroom_errors.dart';
import 'package:pyscore/constants/post_errors.dart';
import 'package:pyscore/models/user.dart';

class AuthResults {
  final bool? success;
  final AuthErrorCode? error;
  final User? userData;

  AuthResults({this.success, this.error, this.userData});

  bool get isSuccess => success != null;
  User get user => userData!;
}

class ClassroomResults {
  final bool? success;
  final ClassroomErrorCode? code;

  ClassroomResults({this.success, this.code});

  bool get isSuccess => success != null;
}

class PostResults {
  final bool? success;
  final PostErrorCode? code;

  PostResults({this.success, this.code});

  bool get isSuccess => success != null;
}
