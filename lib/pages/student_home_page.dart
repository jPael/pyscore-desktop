import 'package:flutter/material.dart';
import 'package:pyscore/components/class_display_drawer.dart';
import 'package:pyscore/components/join_class.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/student_classes_display.dart';
import 'package:pyscore/components/student_drawer.dart';
import 'package:pyscore/components/student_no_classes.dart';
import 'package:pyscore/models/classroom.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

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
        iconTheme: const IconThemeData(
            color: Colors.white), // Set drawer icon color to white
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Row(
              children: [JoinClass()],
            ),
          )
        ],
      ),
      drawer: const StudentDrawer(),
      endDrawer: ClassDisplayDrawer(selectedClass: openedClass ?? null),
      body: Column(
        children: [
          hasClasses
              ? StudentClassesDisplay(handleOpenClass: handleViewClass)
              : StudentNoClasses(),
          ElevatedButton(
              onPressed: () => setState(() {
                    hasClasses = !hasClasses;
                  }),
              child: Text("Switch state"))
        ],
      ));
}
