import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

String formatTime(int seconds) {
  return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
}

String formatDurationToReadableDuration(int totalSeconds) {
  if (totalSeconds == 0) return "No duration";

  final int hours = totalSeconds ~/ 3600;
  final int minutes = (totalSeconds % 3600) ~/ 60;
  final int seconds = totalSeconds % 60;

  List<String> parts = [];

  if (hours > 0) parts.add("$hours ${hours == 1 ? 'hour' : 'hours'}");
  if (minutes > 0) parts.add("$minutes ${minutes == 1 ? 'minute' : 'minutes'}");
  if (seconds > 0) parts.add("$seconds ${seconds == 1 ? 'second' : 'seconds'}");

  return parts.join(" and ");
}

String readableDateTime(String dt) {
  return DateFormat('h:mm a, dd/MM/yy (E)').format(DateTime.parse(dt));
}

int getTimerDuration({required String hours, required String minutes, required String seconds}) {
  final int _hours = int.parse(hours.isEmpty ? "0" : hours);
  final int _minutes = int.parse(minutes.isEmpty ? "0" : minutes);
  final int _seconds = int.parse(seconds.isEmpty ? "0" : seconds);

  return (_hours * 60 * 60) + (_minutes * 60) + _seconds;
}

Future<String?> getDesktopDirectory() async {
  if (Platform.isWindows) {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final String desktopPath = '${appDocumentsDir.parent.path}\\Desktop';
    return desktopPath;
  }
  return null; // Return null if not Windows or path unavailable
}

String rootUrlBuilder(String address, String? port) {
  return 'http://$address${port != null ? ":$port" : ""}';
}
