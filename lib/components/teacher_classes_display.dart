import 'package:flutter/material.dart';
import 'package:pyscore/components/class_card.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/pages/teacher_classroom_page.dart';

class TeacherClassesDisplay extends StatelessWidget {
  const TeacherClassesDisplay({super.key, required this.classrooms});

  final List<Classroom> classrooms;

  void handleOpenClass(
          Classroom classroom, BuildContext context) =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  TeacherClassroomPage(classroom: classroom)));

  @override
  Widget build(BuildContext context) {
    return classrooms.isNotEmpty
        ? Wrap(
            children: classrooms.map((classroom) {
              // final String name = classroom.classroomName;
              // final String section = classroom.section;
              // final String owner = classroom.owner;

              return ClassCard(
                  classroom: classroom, handleOpenClass: handleOpenClass);

              // return GestureDetector(
              //   onTap: () => Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => TeacherClassroomPage(
              //                 classroomId: c.id,
              //               ))),
              //   child: ConstrainedBox(
              //     constraints: const BoxConstraints(
              //       minWidth: 300,
              //     ),
              //     child: Container(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 24, vertical: 12),
              //       margin: const EdgeInsets.all(12),
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(8),
              //           color: Theme.of(context).colorScheme.inversePrimary),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             name,
              //             style: const TextStyle(
              //                 fontSize: 24, fontWeight: FontWeight.w600),
              //           ),
              //           Text(section),
              //           Text(owner)
              //         ],
              //       ),
              //     ),
              //   ),
              // );
            }).toList(),
          )
        : Container();
  }
}
