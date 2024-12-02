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
