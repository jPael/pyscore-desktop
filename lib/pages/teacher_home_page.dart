import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyscore/components/create_class_floating_button.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/server_status_button.dart';
import 'package:pyscore/components/teacher_classes_display.dart';
import 'package:pyscore/components/teacher_drawer.dart';
import 'package:pyscore/components/teacher_no_classes.dart';
import 'package:pyscore/models/my_classrooms.dart';
import 'package:pyscore/models/user.dart';
import 'package:pyscore/services/server/create_server.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({super.key, required this.user});

  final User user;

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  bool isPostsDirty = false;

  final CreateServer server = CreateServer();

  @override
  void initState() {
    super.initState();
    server.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '{ PyScore }',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Row(
                children: [
                  ServerStatusButton(server: server),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: CreateClassFloatingButton(user: widget.user),
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
