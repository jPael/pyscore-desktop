import 'package:flutter/material.dart';
import 'package:pyscore/data/classroom_data.dart';
import 'package:pyscore/models/user.dart';
import 'package:pyscore/pages/teacher_people_page.dart';
import 'package:pyscore/utils/utils.dart';

class TeacherPeopleTab extends StatefulWidget {
  const TeacherPeopleTab({super.key, required this.classroomId});

  final String classroomId;

  @override
  TeacherPeopleTabState createState() => TeacherPeopleTabState();
}

class TeacherPeopleTabState extends State<TeacherPeopleTab> {
  List<User>? members;

  Future<void> handleClassroomMemberFetch() async {
    List<User> _members = await getAllClassroomMember(widget.classroomId);

    setState(() {
      members = _members;
    });
  }

  @override
  void initState() {
    super.initState();
    handleClassroomMemberFetch();
  }

  @override
  Widget build(BuildContext context) {
    return members == null
        ? const Center(child: CircularProgressIndicator())
        : members!.isEmpty
            ? const Center(child: Text("No members found"))
            : ListView.builder(
                itemCount: members!.length,
                itemBuilder: (context, index) {
                  User user = members![index];
                  // print(user.toJson());
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TeacherPeoplePage(user: user))),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        decoration: const BoxDecoration(
                            // border: Border.all(
                            //     color: Colors.black.withOpacity(0.1)),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        padding: const EdgeInsets.all(12.0),
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Student ID: ",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text(user.studentId)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${user.firstname} ${user.lastname} ",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    Text("( ${user.section!} )")
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Joined at ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      readableDateTime(user.createdAt!),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
  }
}
