import 'package:pyscore/constants/auth_errors.dart';
import 'package:pyscore/constants/classroom_errors.dart';
import 'package:pyscore/constants/host_connect_errors.dart';
import 'package:pyscore/constants/post_errors.dart';
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
  final PostErrorCode? code;

  PostResults({this.success, this.code});

  bool get isSuccess => success != null && success == true;
}

class HostConnectResult {
  final bool? success;
  final HostConnectErrorCodes? error;

  HostConnectResult({this.success, this.error});

  bool get isSuccess => success != null && success == true;
}
