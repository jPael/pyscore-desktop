import 'dart:io';

Future<String?> getLocalIPv4Address() async {
  final interfaces = await NetworkInterface.list();
  for (var interface in interfaces) {
    for (var address in interface.addresses) {
      if (address.type == InternetAddressType.IPv4 && !address.isLoopback) {
        // Ignore localhost
        return address.address;
      }
    }
  }
  return null;
}

Future<int> getUnusedPort(String? stringAddress) {
  InternetAddress address = InternetAddress(stringAddress!);
  return ServerSocket.bind(address, 0).then((socket) {
    var port = socket.port;
    socket.close();
    return port;
  });
}
