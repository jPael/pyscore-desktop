import 'dart:convert';
import 'dart:io';

import 'package:mini_server/mini_server.dart';
import 'package:pyscore/data/user_data.dart';
import 'package:pyscore/models/user.dart';
import 'package:pyscore/services/server/server_route_paths/user_routes.dart';

void userRoutes(MiniServer server) {
  server.get(UserRoutes.fetchUserById, (HttpRequest req) async {
    final Map<String, String> paramsQuery = req.uri.queryParameters;

    String id = paramsQuery[UserParamsKey.userId] as String;

    final User? user = await getUserById(id);

    if (user == null) {
      req.response.statusCode = HttpStatus.notFound;
      return;
    }

    final String dataToSent = jsonEncode(user.toJson());

    req.response
      ..statusCode = HttpStatus.ok
      ..write(dataToSent);
  });
}
