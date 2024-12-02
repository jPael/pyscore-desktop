import 'package:flutter/material.dart';
import 'package:pyscore/components/class_card.dart';
import 'package:pyscore/fields/classroom_fields.dart';
import 'package:pyscore/fields/post_fields.dart';
import 'package:pyscore/mockData/classes.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/models/user.dart';

class StudentClassesDisplay extends StatefulWidget {
  const StudentClassesDisplay({super.key, required this.handleOpenClass});

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
            child: Text("ass")
            // Wrap(
            //   children: classes.asMap().entries.map((c) {
            //     // final i = c.key;

            //     final Map<String, dynamic> room = c.value;

            //     final String id = room[ClassroomFields.id];
            //     final String classroomName = room[ClassroomFields.name];
            //     final User owner = room["owner"];
            //     final List<Map<String, dynamic>>? p = room["posts"];
            //     final List<Post> posts = p != null && p.isNotEmpty
            //         ? p
            //             .map((p) => Post(
            //                 id: p[PostFields.id],
            //                 due: p[PostFields.due].toString(),
            //                 instruction: p[PostFields.instruction],
            //                 points: p[PostFields.points],
            //                 title: p[PostFields.title]))
            //             .toList()
            //         : [];

            //     Classroom classroom = Classroom(
            //         id: id,
            //         classroomName: classroomName,
            //         owner: owner,
            //         posts: posts);

            //     return ClassCard(
            //       classroom: classroom,
            //       handleOpenClass: widget.handleOpenClass,
            //     );
            //   }).toList(),
            // )
            ));
  }
}
