import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClassDisplayDrawer extends StatefulWidget {
  const ClassDisplayDrawer({super.key, required this.selectedClass});

  final Map<String, dynamic> selectedClass;

  @override
  State<ClassDisplayDrawer> createState() => _ClassDisplayDrawerState();
}

class _ClassDisplayDrawerState extends State<ClassDisplayDrawer> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>>? classes = widget.selectedClass["posts"];

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
                            "${widget.selectedClass["classroomName"]}",
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                          Text("${widget.selectedClass["owner"]}"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    classes == null || classes.isEmpty
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
                                itemCount: classes.length,
                                itemBuilder: (context, index) {
                                  final String title = classes[index]["title"];
                                  final String instructions =
                                      classes[index]["instructions"];
                                  final String _class = classes[index]["class"];
                                  final String points =
                                      classes[index]["points"].toString();
                                  final String due =
                                      DateFormat('hh:mm a MMMM dd, yyyy')
                                          .format(classes[index]["due"]);
                                  final String createdAt =
                                      DateFormat('hh:mm a MMMM dd, yyyy')
                                          .format(classes[index]["createdAt"]);
                                  final String updatedAt =
                                      DateFormat('hh:mm a MMMM dd, yyyy')
                                          .format(classes[index]["updatedAt"]);

                                  return MouseRegion(
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            // color: index == hoveredIndex
                                            //     ? Theme.of(context)
                                            //         .colorScheme
                                            //         .inversePrimary
                                            //     : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: ListTile(
                                          title: Row(
                                            children: [
                                              Text(title),
                                              const Spacer(),
                                            ],
                                          ),
                                          subtitle: Text(instructions),
                                          trailing: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text("$points Points"),
                                              Text(due)
                                            ],
                                          ),
                                        ),
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
