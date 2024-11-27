import 'package:flutter/material.dart';

class UnfinishedChip extends StatelessWidget {
  const UnfinishedChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      // labelPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 3),
      label: const Text(
        "Unfinished",
        style: TextStyle(fontSize: 12),
      ),
      backgroundColor: Colors.redAccent.withOpacity(0.2),
      side: const BorderSide(color: Colors.red),
    );
  }
}
