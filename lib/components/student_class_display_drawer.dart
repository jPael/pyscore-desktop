import 'package:flutter/material.dart';
import 'package:pyscore/components/student_class_display_drawer_item.dart';
import 'package:pyscore/data/post_data.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/models/posts.dart';

class ClassDisplayDrawer extends StatefulWidget {
  const ClassDisplayDrawer({super.key, required this.selectedClass});

  final Classroom? selectedClass;

  @override
  State<ClassDisplayDrawer> createState() => _ClassDisplayDrawerState();
}

class _ClassDisplayDrawerState extends State<ClassDisplayDrawer> {
  List<Post>? posts;

  int? hoveredIndex;
  bool isLoading = false;

  Future<void> fetchPosts() async {
    setState(() {
      isLoading = true;
    });

    List<Post>? p = await getAllPostsByClassId(widget.selectedClass!.id!);

    setState(() {
      posts = p;
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.2,
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: widget.selectedClass == null
            ? const Text("No class was selected")
            : Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.selectedClass!.classroomName,
                            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                          Text(
                              "${widget.selectedClass!.owner.firstname} ${widget.selectedClass!.owner.lastname}"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : posts == null
                            ? Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          "There are no posts in this class",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500,
                                              color: Theme.of(context).colorScheme.secondary),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    itemCount: posts!.length,
                                    itemBuilder: (context, index) {
                                      final Post currentPost = posts![index];

                                      return StudentClassDisplayDrawerItem(
                                        currentPost: currentPost,
                                        index: index,
                                      );
                                    })),
                  ],
                ),
              ),
      ),
    );
  }
}
