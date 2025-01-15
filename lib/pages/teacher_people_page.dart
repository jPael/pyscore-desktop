import 'package:flutter/material.dart';
import 'package:pyscore/models/user.dart';

class TeacherPeoplePage extends StatelessWidget {
  const TeacherPeoplePage({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Member: ${user.firstname}"),
      ),
    );
  }
}
