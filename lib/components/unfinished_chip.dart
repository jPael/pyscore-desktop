import 'package:flutter/material.dart';

class UnfinishedChip extends StatelessWidget {
  const UnfinishedChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      // labelPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 3),

      label: const Icon(
        Icons.pending,
        color: Colors.white,
      ),
      backgroundColor: Colors.red[400],
      side: const BorderSide(color: Colors.red),
    );
  }
}
