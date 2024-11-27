import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pyscore/components/class_card.dart';
import 'package:pyscore/mockData/classes.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/teacher/pages/handled_classes.dart';

class StudentClassesDisplay extends StatefulWidget {
  StudentClassesDisplay({super.key, required this.handleOpenClass});

  final Function handleOpenClass;

  @override
  State<StudentClassesDisplay> createState() => _StudentClassesDisplayState();
}

class _StudentClassesDisplayState extends State<StudentClassesDisplay> {
  final classes = Classes().classData;
  int? hoveredClasses;

  // void debugList(List<Map<String, dynamic>> list) {
  @override
  Widget build(BuildContext context) {
    // debugList(classes);

    return Expanded(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Theme.of(context).colorScheme.surface,
            child: Wrap(
              children: classes.asMap().entries.map((c) {
                final i = c.key;

                final Map<String, dynamic> room = c.value;

                final String id = room["id"];
                final String classroomName = room["classroomName"];
                final String section = room["section"];
                final String owner = room["owner"];
                final List<Map<String, dynamic>>? p = room["posts"];
                final List<Posts> posts = p != null && p.isNotEmpty
                    ? p
                        .map((p) => Posts(
                            id: p["id"],
                            due: p["due"].toString(),
                            instructions: p["instructions"],
                            points: p["points"],
                            title: p["title"]))
                        .toList()
                    : [];

                Classroom classroom =
                    Classroom(id, classroomName, section, owner, posts);

                return ClassCard(
                  classroom: classroom,
                  handleOpenClass: widget.handleOpenClass,
                );
              }).toList(),
            )));
  }
}
