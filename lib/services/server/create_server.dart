import 'package:mini_server/mini_server.dart';
import 'package:pyscore/services/server/server_route_listeners/auth_routes.dart';
import 'package:pyscore/services/server/server_route_listeners/class_routes.dart';
import 'package:pyscore/services/server/server_route_listeners/connection_routes.dart';
import 'package:pyscore/services/server/server_route_listeners/user_routes.dart';
import 'package:pyscore/utils/ip.dart';

class CreateServer {
  static final CreateServer _instance = CreateServer._internal();

  int? _port;
  MiniServer? _server;
  String? _ip;

  CreateServer._internal();

  factory CreateServer() => _instance;

  Future<void> initialize() async {
    if (_server != null) return;

    _ip = await getLocalIPv4Address();
    _port = await getUnusedPort(_ip);

    _server = MiniServer(
      host: _ip!,
      port: _port!,
    );

    if (_server != null) {
      hostConnectionRoutes(_server!);
      authRoutes(_server!);
      classRoutes(_server!);
      userRoutes(_server!);
    }
  }

  String? get ip => _ip;
  int? get port => _port;
}
