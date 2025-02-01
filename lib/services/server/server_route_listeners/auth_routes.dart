import 'dart:convert';
import 'dart:io';

import 'package:crypt/crypt.dart';
import 'package:mini_server/mini_server.dart';
import 'package:pyscore/constants/errors/auth_errors.dart';
import 'package:pyscore/fields/user_fields.dart';
import 'package:pyscore/models/user.dart';
import 'package:pyscore/services/db.dart';
import 'package:pyscore/services/server/server_route_paths/auth_routes.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void authRoutes(MiniServer server) {
  server.post(AuthRoutes.studentSignin, (HttpRequest req) async {
    final content = await utf8.decoder.bind(req).join();

    final data = jsonDecode(content) as Map<String, Object?>;

    Database db = await Db.instance.db;

    final row = await db.query(userTableName,
        where: "${UserFields.studentId} = ?", whereArgs: [data[UserFields.studentId]]);

    if (row.isEmpty) {
      req.response.statusCode = HttpStatus.notFound;
      return;
    }

    final String inputPassword = data[UserFields.password] as String;
    final String storedPassword = row[0][UserFields.password] as String;

    final c = Crypt(storedPassword);

    if (!c.match(inputPassword)) {
      req.response.statusCode = HttpStatus.forbidden;
      return;
    }

    req.response
      ..statusCode = HttpStatus.ok
      ..write(jsonEncode(row[0]));
  });

  server.post(AuthRoutes.studentSignup, (HttpRequest req) async {
    try {
      final content = await utf8.decoder.bind(req).join();
      final data = jsonDecode(content) as Map<String, dynamic>;

      final Database db = await Db.instance.db;

      final int res = await db.insert(userTableName, data);

      if (res == 0) {
        req.response
          ..statusCode = HttpStatus.expectationFailed
          ..write(Autherrors.error(AuthErrorCode.unableToSignUp));
      }

      req.response
        ..statusCode = HttpStatus.ok
        ..write("Data received successfully");
    } catch (e) {
      req.response
        ..statusCode = HttpStatus.badRequest
        ..write("Failed to process data: $e");
    } finally {
      await req.response.close();
    }
  });
}
