import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pyscore/constants/user_type.dart';
import 'package:pyscore/data/classroom_data.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/services/host_connection.dart';
import 'package:pyscore/services/server/server_route_paths/class_routes.dart';
import 'package:pyscore/utils/utils.dart';

Future<List<Classroom?>> getAllClassroomByUserId(String id, String userType) async {
  if (userType == UserType.teacher) {
    return getAllClassroomAsTeacher(id);
  } else {
    final String? ip = HostConnection().ip;
    final String? port = HostConnection().port;

    if (ip == null) {
      return [];
    }

    final Uri url = Uri.parse("${rootUrlBuilder(ip, port!)}${ClassRoutes.allStudentsClass}");

    try {
      final http.Response res = await http.post(url,
          headers: {'content-type': 'application/json'}, body: jsonEncode({"userId": id}));

      if (res.statusCode == HttpStatus.ok) {
        final List<dynamic> resBody = jsonDecode(res.body);

        final List<Map<String, Object?>> listOfClassroom = resBody.map((item) {
          final Map<String, Object?> newItem = item;

          return newItem;
        }).toList();

        return await Future.wait(listOfClassroom.map((c) async {
          return await Classroom.fromJson(c);
        }));
      }

      return [];
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print("There was a problem in the server: $e");
        print(stacktrace);
      }

      return [];
    }
  }
}
