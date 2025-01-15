import 'package:flutter/material.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/show_classroom_code_button.dart';
import 'package:pyscore/components/teacher_delete_classroom_button.dart';
import 'package:pyscore/components/teacher_people_tab.dart';
import 'package:pyscore/components/teacher_post_tab.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/pages/teacher_create_post.dart';

class TeacherClassroomPage extends StatefulWidget {
  const TeacherClassroomPage({
    super.key,
    required this.classroom,
  });

  final Classroom classroom;

  @override
  State<TeacherClassroomPage> createState() => _TeacherClassroomPageState();
}

class _TeacherClassroomPageState extends State<TeacherClassroomPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool postIsDirty = false;

  void setPostToDirty() => setState(() {
        postIsDirty = true;
      });

  void setPostToClean() => setState(() {
        postIsDirty = false;
      });

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose(); // Important to dispose of the TabController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String sample = "jason pael";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Classroom"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Row(
              children: [
                TeacherDeleteClassroomButton(classroom: widget.classroom)
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Post an activity"),
        tooltip: "Post an activity",
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TeacherCreatePost(
                    classroom: widget.classroom,
                    setPostToDirty: setPostToDirty))),
        icon: const Icon(Icons.post_add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 150),
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: TabBar(controller: _tabController, tabs: const [
                          Tab(child: Text("Feed")),
                          Tab(child: Text("People")),
                          Tab(child: Text("Report"))
                        ]),
                      ),
                      SizedBox(
                        child: Text(
                          widget.classroom.classroomName,
                          style: const TextStyle(fontSize: 32),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: 150, maxWidth: 160),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                                startIcon: Icons.refresh,
                                label: "Refresh",
                                onTap: () {
                                  setState(() {
                                    postIsDirty = true;
                                  });
                                }),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ShowClassroomCodeButton(
                                code: widget.classroom.code ?? ''),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              TeacherPostTab(
                  classroomId: widget.classroom.id!,
                  isPostDirty: postIsDirty,
                  setPostToClean: setPostToClean,
                  setPostToDirty: setPostToDirty),
              TeacherPeopleTab(
                classroomId: widget.classroom.id!,
              ),
              const Text("report")
            ]),
          )
        ],
      ),
    );
  }
}
