import 'package:pyscore/constants/auth_errors.dart';
import 'package:pyscore/models/user.dart';

class AuthResults {
  final bool? success;
  final AuthErrorCode? error;
  final User? userData;

  AuthResults({this.success, this.error, this.userData});

  bool get isSuccess => success != null;
  User get user => userData!;
}
