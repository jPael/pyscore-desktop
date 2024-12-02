import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/show_classroom_code_button.dart';
import 'package:pyscore/data/post_data.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/pages/teacher_create_post.dart';
import 'package:pyscore/utils/utils.dart';
import 'package:recase/recase.dart';

class TeacherClassroomPage extends StatefulWidget {
  const TeacherClassroomPage({super.key, required this.classroom});

  final Classroom classroom;

  @override
  State<TeacherClassroomPage> createState() => _TeacherClassroomPageState();
}

class _TeacherClassroomPageState extends State<TeacherClassroomPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Post>? posts = [];

  Future<void> initializePosts() async {
    List<Post> _posts = await getPostsByClassId(widget.classroom.id!);

    setState(() {
      posts = _posts;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);

    initializePosts();
  }

  @override
  void dispose() {
    _tabController.dispose(); // Important to dispose of the TabController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Classroom"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CustomButton(
              label: "Post an activity",
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TeacherCreatePost(
                          classroom: widget.classroom,
                          initializePosts: initializePosts))),
            ),
          )
        ],
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
              child: Column(
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
                  Row(
                    children: [
                      Text(
                        widget.classroom.classroomName,
                        style: const TextStyle(fontSize: 32),
                      ),
                      const Spacer(),
                      ShowClassroomCodeButton(code: widget.classroom.code ?? '')
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              posts!.isNotEmpty
                  ? ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: posts?.length ?? 0,
                      itemBuilder: (context, index) {
                        final Post p = posts![index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Posted on ${DateFormat('h:mm a, dd/MM/yy (E)').format(DateTime.parse(p.createdAt!))}",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      p.title.titleCase,
                                      softWrap: true,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            p.instruction,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                      "Due on ${DateFormat('h:mm a, dd/MM/yy (E)').format(DateTime.parse(p.due))}"),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text("${p.points.toString()} points"),
                                  Text(
                                      "Duration: ${formatDurationToReadableDuration(p.duration)}")
                                ],
                              )
                            ],
                          ),
                        );
                      })
                  : Text("No post"),
              const Text("people"),
              const Text("report")
            ]),
          )
        ],
      ),
    );
  }
}
