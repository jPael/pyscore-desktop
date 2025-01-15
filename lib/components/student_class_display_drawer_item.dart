import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/pages/student_activity_page.dart';
import 'package:pyscore/utils/utils.dart';

class StudentClassDisplayDrawerItem extends StatefulWidget {
  const StudentClassDisplayDrawerItem(
      {super.key, required this.currentPost, required this.index});

  final int index;
  final Post currentPost;

  @override
  StudentClassDisplayDrawerItemState createState() =>
      StudentClassDisplayDrawerItemState();
}

// finish the student side
class StudentClassDisplayDrawerItemState
    extends State<StudentClassDisplayDrawerItem> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    String? instruction = "No instruction";

    try {
      instruction =
          Document.fromJson(jsonDecode(widget.currentPost.instruction))
              .toPlainText();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  StudentActivityPage(post: widget.currentPost))),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          setState(() {
            hoveredIndex = widget.index;
          });
        },
        onExit: (_) {
          setState(() {
            hoveredIndex = null;
          });
        },
        child: Badge(
          backgroundColor: Colors.green[600],
          label: const Icon(
            Icons.check,
            color: Colors.white,
          ),
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Posted on ",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              readableDateTime(widget.currentPost.createdAt!),
                              style: const TextStyle(fontSize: 12),
                            ),
                            const Spacer(),
                            const Text(
                              "Due on ",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              readableDateTime(widget.currentPost.due),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.currentPost.title,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const Row(
                              children: [
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "Points ",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "80",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text("/100")
                              ],
                            )
                          ],
                        ),
                        // const SizedBox(
                        //   height: 6,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(instruction!),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
