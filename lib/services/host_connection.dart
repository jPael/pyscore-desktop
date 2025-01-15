import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:pyscore/constants/host_connect_errors.dart";
import "package:pyscore/utils/results.dart";

class HostConnection extends ChangeNotifier {
  String? _ip;
  String? _port;
  bool isConnected = false;

  String? get ip => _ip;
  String? get port => _port;

  static final HostConnection _instance = HostConnection._internal();

  factory HostConnection() {
    return _instance;
  }

  HostConnection._internal();

  void setHostAddress(String hostIp, String hostPort) {
    _ip = hostIp;
    _port = hostPort;
    notifyListeners();
  }

  void setIsConnected(bool connected) {
    isConnected = connected;

    notifyListeners();
  }

  void disconnect(BuildContext context) {
    _ip = null;
    _port = null;
    isConnected = false;
    Navigator.pop(context);
    notifyListeners();
  }

  Future<HostConnectResult> connect() async {
    // print("is ip $ip null? ${ip == null || ip == ""}");
    // print("is port $port null? ${port == null || port == ""}");

    if (_ip == null || _ip == "") {
      return HostConnectResult(success: false, error: HostConnectErrorCodes.noIPAddressEntered);
    }

    if (_port == null || _port == "") {
      return HostConnectResult(success: false, error: HostConnectErrorCodes.noPortEntered);
    }

    final url = Uri.parse('http://$_ip:$_port/connect');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setIsConnected(true);

        return HostConnectResult(success: true);
      } else {
        setIsConnected(false);

        return HostConnectResult(success: false, error: HostConnectErrorCodes.hostNotFound);
      }
    } catch (e) {
      print("Can't reach the address: $e");
      return HostConnectResult(success: false, error: HostConnectErrorCodes.hostNotFound);
    }
  }
}
