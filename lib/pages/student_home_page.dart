import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyscore/components/refresh_class_button.dart';
import 'package:pyscore/components/student_class_display_drawer.dart';
import 'package:pyscore/components/join_class_button.dart';
import 'package:pyscore/components/student_classes_display.dart';
import 'package:pyscore/components/student_drawer.dart';
import 'package:pyscore/components/student_no_classes.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/models/my_classrooms.dart';
import 'package:pyscore/models/user.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key, required this.user});
  final User user;

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  bool hasClasses = true;

  Classroom? openedClass;

  void handleViewClass(Classroom selectedClass, BuildContext context) {
    setState(() {
      openedClass = selectedClass;
    });
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text(
          'My class',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white), // Set drawer icon color to white
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              children: [
                const RefreshClassButton(),
                const SizedBox(
                  width: 12,
                ),
                JoinClassButton(userId: widget.user.id!),
                const SizedBox(
                  width: 12,
                ),
                Tooltip(
                  message: "signed in as",
                  child: Text(
                    "${widget.user.firstname} ${widget.user.lastname}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      drawer: const StudentDrawer(),
      endDrawer: ClassDisplayDrawer(selectedClass: openedClass),
      body: Consumer<MyClassrooms>(
        builder: (context, myClassroom, child) {
          List<Classroom> classrooms = myClassroom.myClassrooms;

          return Column(
            children: [
              hasClasses
                  ? StudentClassesDisplay(classrooms: classrooms, handleOpenClass: handleViewClass)
                  : StudentNoClasses(),
              ElevatedButton(
                  onPressed: () => setState(() {
                        hasClasses = !hasClasses;
                      }),
                  child: const Text("Switch state"))
            ],
          );
        },
      ));
}
