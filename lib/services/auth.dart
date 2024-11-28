import 'package:crypt/crypt.dart';
import 'package:pyscore/constants/auth_errors.dart';
import 'package:pyscore/data/user_data.dart';
import 'package:pyscore/models/user.dart';
import 'package:pyscore/utils/auth_results.dart';

class Auth {
  final String username;
  final String password;

  Auth({required this.username, required this.password});

  Future<AuthResults> signIn() async {
    try {
      final User? user = await getUserByUsername(username);

      if (user == null) {
        return AuthResults(error: AuthErrorCode.userNotFound);
      }
      final c = Crypt(user.password!);

      if (!c.match(password)) {
        return AuthResults(error: AuthErrorCode.wrongPassword);
      }

      return AuthResults(success: true, userData: user);
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return AuthResults(error: AuthErrorCode.serverError);
    }
  }
}
