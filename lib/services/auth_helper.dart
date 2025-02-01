import 'dart:convert';
import 'dart:io';

import 'package:crypt/crypt.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pyscore/constants/errors/auth_errors.dart';
import 'package:pyscore/data/user_data.dart';
import 'package:pyscore/fields/user_fields.dart';
import 'package:pyscore/models/user.dart';
import 'package:pyscore/services/db.dart';
import 'package:pyscore/services/host_connection.dart';
import 'package:pyscore/services/server/server_route_paths/auth_routes.dart';
import 'package:pyscore/utils/results.dart';
import 'package:pyscore/utils/utils.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<AuthResults> signinAsTeacher(String username, String password) async {
  final User? user = await getUserByUsername(username);

  if (user == null) {
    return AuthResults(success: false, error: AuthErrorCode.userNotFound);
  }

  final c = Crypt(user.password!);

  if (!c.match(password)) {
    return AuthResults(success: false, error: AuthErrorCode.wrongPassword);
  }

  return AuthResults(success: true, userData: user);
}

Future<AuthResults> signinAsStudent(String username, String password) async {
  final String? ip = HostConnection().ip;
  final String? port = HostConnection().port;

  if (ip == null) {
    return AuthResults(success: false, error: AuthErrorCode.notConnectedToServer);
  }

  final url = Uri.parse("${rootUrlBuilder(ip, port)}${AuthRoutes.studentSignin}");

  final Response res = await http.post(url,
      headers: {"content-type": "application/json"},
      body: jsonEncode({UserFields.studentId: username, UserFields.password: password}));

  if (res.statusCode == HttpStatus.notFound) {
    return AuthResults(success: false, error: AuthErrorCode.studentNotFound);
  } else if (res.statusCode == HttpStatus.forbidden) {
    return AuthResults(success: false, error: AuthErrorCode.wrongPassword);
  } else if (res.statusCode == HttpStatus.serviceUnavailable) {
    return AuthResults(success: false, error: AuthErrorCode.serverError);
  }

  final String resBody = res.body;

  final Map<String, Object?> data = jsonDecode(resBody) as Map<String, Object?>;

  final User user = User.fromJson(data);

  return AuthResults(success: true, userData: user);
}

Future<AuthResults> signupAsTeacher(Map<String, Object?> data) async {
  final Database db = await Db.instance.db;

  final int res = await db.insert(userTableName, data);

  if (res == 0) {
    return AuthResults(success: false, error: AuthErrorCode.unableToSignUp);
  }

  return AuthResults(success: true);
}

Future<AuthResults> signupAsStudent(Map<String, Object?> data) async {
  final String? ip = HostConnection().ip;
  final String? port = HostConnection().port;

  if (ip == null) {
    return AuthResults(success: false, error: AuthErrorCode.notConnectedToServer);
  }

  final url = Uri.parse("${rootUrlBuilder(ip, port)}${AuthRoutes.studentSignup}");

  final Response res =
      await http.post(url, headers: {'content-type': 'application/json'}, body: jsonEncode(data));

  if (res.statusCode == 200) {
    if (kDebugMode) {
      print("Data posted successfully");
    }
    return AuthResults(success: true);
  } else {
    throw Exception('Failed to post data: ${res.statusCode}');
  }
}
