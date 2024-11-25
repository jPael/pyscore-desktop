import 'package:flutter/material.dart';


class Archivedclasses extends StatelessWidget {
  const Archivedclasses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Archived Classes', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white), // Set
      ),
    );
  }
}