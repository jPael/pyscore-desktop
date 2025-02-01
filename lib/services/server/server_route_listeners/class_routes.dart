import 'dart:convert';
import 'dart:io';

import 'package:mini_server/mini_server.dart';
import 'package:pyscore/data/classroom_data.dart';
import 'package:pyscore/data/post_data.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/services/server/server_route_paths/class_routes.dart';

void classRoutes(MiniServer server) {
  server.post(ClassRoutes.joinClass, (HttpRequest req) async {
    final content = await utf8.decoder.bind(req).join();
    final data = jsonDecode(content) as Map<String, dynamic>;

    final String classroomCode = data["classroomCode"];
    final String userId = data["userId"];

    final Classroom? classroom = await getClassroomByCode(classroomCode);

    if (classroom == null) {
      req.response.statusCode = HttpStatus.notFound;
    }

    final bool result = await joinClassroom(userId, classroom!.id!);

    if (result) {
      req.response.statusCode = HttpStatus.ok;
      return;
    } else {
      req.response.statusCode = HttpStatus.expectationFailed;
      return;
    }
  });

  server.post(ClassRoutes.allStudentsClass, (HttpRequest req) async {
    final content = await utf8.decoder.bind(req).join();
    final data = jsonDecode(content) as Map<String, dynamic>;

    String id = data[ClassParamsKey.classId];

    final List<Classroom?> classes = await getAllClassroomAsStudent(id);

    final String returnData = jsonEncode(classes);

    req.response
      ..statusCode = HttpStatus.ok
      ..write(returnData);
  });

  server.get(ClassRoutes.getAllPostByClassId, (HttpRequest req) async {
    final Map<String, String> paramsQuery = req.uri.queryParameters;

    final String classId = paramsQuery[ClassParamsKey.classId] as String;

    final List<Post> posts = await getAllPostsByClassId(classId);

    req.response
      ..statusCode = HttpStatus.ok
      ..write(jsonEncode(posts));
  });
}
