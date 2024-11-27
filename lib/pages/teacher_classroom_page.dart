import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/models/my_classrooms.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/pages/teacher_create_post.dart';

class TeacherClassroomPage extends StatelessWidget {
  const TeacherClassroomPage({super.key, required this.classroomId});

  final String classroomId;

  @override
  Widget build(BuildContext context) {
    return Consumer<MyClassrooms>(
      builder: (context, myClassrooms, child) {
        final List<Classroom> classrooms = myClassrooms.myClassrooms;
        final Classroom classroom =
            classrooms.firstWhere((c) => c.id == classroomId);

        return Scaffold(
          appBar: AppBar(
            title: Text(classroom.classroomName),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Row(
                  children: [
                    CustomButton(
                        label: "Post an activity",
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TeacherCreatePost(classroom: classroom)))),
                  ],
                ),
              )
            ],
          ),
          body: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: classroom.posts.length,
              itemBuilder: (context, index) {
                final Posts p = classroom.posts[index];

                return ListTile(
                  title: Text(p.title),
                  subtitle: Text(p.instructions),
                  trailing: Text(p.points.toString()),
                );
              }),
        );
      },
    );
  }
}
