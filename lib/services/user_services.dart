import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pyscore/constants/classroom_errors.dart';
import 'package:pyscore/models/user.dart';
import 'package:pyscore/services/host_connection.dart';
import 'package:pyscore/services/server/server_route_paths/class_routes.dart';
import 'package:pyscore/services/server/server_route_paths/user_routes.dart';
import 'package:pyscore/utils/results.dart';
import 'package:pyscore/utils/utils.dart';

Future<ClassroomResults> joinClass(String userId, String classCode) async {
  if (classCode.isEmpty || classCode == "") {
    return ClassroomResults(success: false, error: ClassroomErrorCode.classroomCodeIsEmpty);
  }

  // Classroom? classroom = await getClassroomByCode(classCode);

// now proceed with joining the classroom
  // bool joinedSuccessfully = await joinClassroom(userId, classroom.id!);

  final String? ip = HostConnection().ip;
  final String? port = HostConnection().port;

  if (ip == null) {
    return ClassroomResults(success: false, error: ClassroomErrorCode.notConnectedToTheServer);
  }

  final url = Uri.parse("${rootUrlBuilder(ip, port)}${ClassRoutes.joinClass}");

  try {
    print("sending http request to join");
    final Response res = await http.post(url,
        headers: {
          'content-type': "application/json",
        },
        body: jsonEncode({"classroomCode": classCode, "userId": userId}));

    if (res.statusCode == HttpStatus.notFound) {
      return ClassroomResults(success: false, error: ClassroomErrorCode.classroomNotFound);
    } else if (res.statusCode == HttpStatus.expectationFailed) {
      return ClassroomResults(success: false, error: ClassroomErrorCode.classroomJoinError);
    } else if (res.statusCode == HttpStatus.ok) {
      return ClassroomResults(success: true);
    }

    return ClassroomResults(success: false, error: ClassroomErrorCode.serverError);
  } catch (e) {
    if (kDebugMode) {
      print("There was a problem joining into a classroom $e");
    }
    return ClassroomResults(success: false, error: ClassroomErrorCode.serverError);
  }
}

Future<User?> fetchUserById(String id) async {
  if (id.isEmpty) {
    return null;
  }

  final String? ip = HostConnection().ip;
  final String? port = HostConnection().port;

  if (ip == null) {
    return null;
  }

  final Uri url = Uri.parse("${rootUrlBuilder(ip, port)}${UserRoutes.fetchUserById}")
      .replace(queryParameters: {UserParamsKey.userId: id});

  final http.Response res = await http.get(url);

  User? owner = User.fromJson(jsonDecode(res.body) as Map<String, Object?>);

  return owner;
}
