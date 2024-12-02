import 'package:flutter/material.dart';
import 'package:pyscore/components/unfinished_chip.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/pages/student_activity_page.dart';

class ClassDisplayDrawer extends StatefulWidget {
  const ClassDisplayDrawer({super.key, required this.selectedClass});

  final Classroom? selectedClass;

  @override
  State<ClassDisplayDrawer> createState() => _ClassDisplayDrawerState();
}

class _ClassDisplayDrawerState extends State<ClassDisplayDrawer> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final List<Post> posts = widget.selectedClass!.posts!;

    // print("is there a posts ${posts.isEmpty}");

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
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.selectedClass!.classroomName,
                            style: const TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
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
                    posts.isEmpty
                        ? Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 50.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "There are no posts in this class",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: posts.length,
                                itemBuilder: (context, index) {
                                  final Post currentPost = posts[index];

                                  final String title = currentPost.title;
                                  final String instructions =
                                      currentPost.instruction;
                                  // final String points = currentPost.points;
                                  // final String due = DateFormat(
                                  //         'hh:mm a MMMM dd, yyyy')
                                  //     .format(DateTime.parse(currentPost.due));

                                  return GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StudentActivityPage(
                                                    post: currentPost))),
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      onEnter: (_) {
                                        setState(() {
                                          hoveredIndex = index;
                                        });
                                      },
                                      onExit: (_) {
                                        setState(() {
                                          hoveredIndex = null;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12, right: 12, bottom: 18.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                // color: index == hoveredIndex
                                                //     ? Theme.of(context)
                                                //         .colorScheme
                                                //         .inversePrimary
                                                //     : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            title,
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          const Row(
                                                            children: [
                                                              UnfinishedChip(),
                                                              SizedBox(
                                                                width: 6,
                                                              ),
                                                              Text("80/100")
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 6,
                                                      ),
                                                      Text(instructions)
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  );
                                })),
                  ],
                ),
              ),
      ),
    );
  }
}
