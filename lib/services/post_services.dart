import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:pyscore/constants/errors/post_errors.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/services/host_connection.dart';
import 'package:pyscore/services/server/server_route_paths/post_routes.dart';
import 'package:pyscore/utils/results.dart';
import 'package:pyscore/utils/utils.dart';
import 'package:http/http.dart' as http;

Future<PostResults> fetchPostById(String id) async {
  if (id.isEmpty) {
    return PostResults(success: false, error: PostErrorCode.noId);
  }

  final String? ip = HostConnection().ip;
  final String? port = HostConnection().port;

  if (ip == null) {
    return PostResults(success: false, error: PostErrorCode.notConnected);
  }

  try {
    final url = Uri.parse("${rootUrlBuilder(ip, port)}${PostRoutes.post}")
        .replace(queryParameters: {PostParamsKey.postId: id});

    final http.Response res = await http.get(url);

    if (res.statusCode == HttpStatus.notFound) {
      return PostResults(success: false, error: PostErrorCode.postNotFound);
    }

    final dynamic postJson = jsonDecode(res.body);

    final Post post = await Post.fromJson(postJson);

    return PostResults(success: true, post: post);
  } catch (e, stackTrace) {
    if (kDebugMode) {
      print(e);
      print(stackTrace);
    }
    return PostResults(success: false, error: PostErrorCode.error);
  }
}
