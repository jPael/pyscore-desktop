import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyscore/components/create_class_button.dart';
import 'package:pyscore/components/teacher_classes_display.dart';
import 'package:pyscore/components/teacher_drawer.dart';
import 'package:pyscore/components/teacher_no_classes.dart';
import 'package:pyscore/models/my_classrooms.dart';
import 'package:pyscore/models/user.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({super.key, required this.user});

  final User user;

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '{ PyScore }',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(
              color: Colors.white), // Set drawer icon color to white
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Row(
                children: [
                  CreateClassButton(user: widget.user),
                  const SizedBox(
                    width: 12,
                  ),
                  Tooltip(
                    message: "signed in as",
                    child: Text(
                      "${widget.user.firstname} ${widget.user.lastname}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        drawer: const TeacherDrawer(),
        // endDrawer: ClassDisplayDrawer(selectedClass: openedClass),
        body: Consumer<MyClassrooms>(
          builder: (context, myClassrooms, child) {
            final classrooms = myClassrooms.myClassrooms;
            bool hasClasses = classrooms.isNotEmpty;

            return Column(
              children: [
                hasClasses
                    ? TeacherClassesDisplay(
                        classrooms: classrooms,
                      )
                    : TeacherNoClasses(
                        user: widget.user,
                      ),
              ],
            );
          },
        ));
  }
}
