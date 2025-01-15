import 'dart:io';

import 'package:mini_server/mini_server.dart';
import 'package:pyscore/services/server/server_route_paths/connection_routes.dart';

void hostConnectionRoutes(MiniServer server) {
  server.get(HostRoutes.connect, (HttpRequest req) async {
    return req.response.statusCode = HttpStatus.ok;
  });
}
