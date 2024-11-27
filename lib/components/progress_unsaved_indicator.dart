import 'package:flutter/material.dart';

class ProgressUnsavedIndicator extends StatelessWidget {
  const ProgressUnsavedIndicator(
      {super.key, required this.hasNotSaved, this.onlyIcon = false});

  final bool hasNotSaved;
  final bool? onlyIcon;

  @override
  Widget build(BuildContext context) {
    if (hasNotSaved) {
      return const Icon(
        Icons.circle,
        size: 12,
        color: Colors.red,
      );
    } else {
      return const Icon(
        Icons.circle,
        size: 12,
        color: Colors.green,
      );
    }
  }
}
