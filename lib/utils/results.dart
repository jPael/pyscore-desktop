import 'package:pyscore/constants/errors/auth_errors.dart';
import 'package:pyscore/constants/errors/classroom_errors.dart';
import 'package:pyscore/constants/errors/host_connect_errors.dart';
import 'package:pyscore/constants/errors/post_errors.dart';
import 'package:pyscore/constants/errors/user_errors.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/models/user.dart';

class AuthResults {
  final bool? success;
  final AuthErrorCode? error;
  final User? userData;

  AuthResults({this.success, this.error, this.userData});

  bool get isSuccess => success != null && success == true;
  User get user => userData!;
}

class ClassroomResults {
  final bool? success;
  final ClassroomErrorCode? error;

  ClassroomResults({this.success, this.error});

  bool get isSuccess => success != null && success == true;
}

class PostResults {
  final bool? success;
  final PostErrorCode? error;
  final Post? _post;

  PostResults({this.success, this.error, Post? post}) : _post = post;

  bool get isSuccess => success != null && success == true;
  Post? get post => _post;
}

class HostConnectResult {
  final bool? success;
  final HostConnectErrorCodes? error;

  HostConnectResult({this.success, this.error});

  bool get isSuccess => success != null && success == true;
}

class UserResults {
  final bool? success;
  final UserErrorCodes? error;
  final User? _user;

  UserResults({this.success, this.error, User? user}) : _user = user;

  bool get isSuccess => success != null && success == true;

  User? get user => _user;
}
