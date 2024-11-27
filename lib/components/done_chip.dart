import 'package:flutter/material.dart';

class DoneChip extends StatelessWidget {
  const DoneChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      // labelPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 3),
      label: const Text(
        "Done",
        style: TextStyle(fontSize: 12),
      ),
      backgroundColor: Colors.greenAccent.withOpacity(0.3),
      side: const BorderSide(color: Colors.green),
    );
  }
}
