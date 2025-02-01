import 'dart:convert';
import 'dart:io';

import 'package:mini_server/mini_server.dart';
import 'package:pyscore/data/post_data.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/services/server/server_route_paths/post_routes.dart';

void userPost(MiniServer server) {
  server.post(PostRoutes.saveFile, (HttpRequest req) async {
    final content = await utf8.decoder.bind(req).join();
    final data = jsonDecode(content);

    //TODO:: finish the remote save
  });

  server.get(PostRoutes.post, (HttpRequest req) async {
    final Map<String, String> paramsQuery = req.uri.queryParameters;

    final String postId = paramsQuery[PostParamsKey.postId] as String;

    final Post? post = await getPostById(postId);

    if (post == null) {
      req.response.statusCode = HttpStatus.notFound;
      return;
    }

    req.response
      ..statusCode = HttpStatus.ok
      ..write(jsonEncode(post));
  });
}
