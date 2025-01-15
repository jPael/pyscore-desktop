import 'package:flutter/material.dart';

class TeacherNoPostPrompt extends StatelessWidget {
  const TeacherNoPostPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "No post",
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.3)),
        )
      ],
    ));
  }
}
