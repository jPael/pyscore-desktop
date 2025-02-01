import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/teacher_no_post_prompt.dart';
import 'package:pyscore/data/post_data.dart';
import 'package:pyscore/constants/types/custom_button_type.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/pages/teacher_edit_post_page.dart';
import 'package:pyscore/utils/utils.dart';
import 'package:recase/recase.dart';

class TeacherPostTab extends StatefulWidget {
  const TeacherPostTab({
    super.key,
    required this.classroomId,
    required this.isPostDirty,
    required this.setPostToClean,
    required this.setPostToDirty,
  });

  final String classroomId;
  final bool isPostDirty;
  final Function setPostToClean;
  final Function setPostToDirty;

  @override
  State<TeacherPostTab> createState() => _TeacherPostTabState();
}

class _TeacherPostTabState extends State<TeacherPostTab> {
  List<Post>? posts;
  bool isFetching = true;

  Future<void> initializePosts() async {
    // ignore: no_leading_underscores_for_local_identifiers
    List<Post> _posts = await getAllPostsByClassId(widget.classroomId);
    widget.setPostToClean();

    setState(() {
      posts = _posts;
      isFetching = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initializePosts();
  }

  @override
  @override
  Widget build(BuildContext context) {
    if (widget.isPostDirty) {
      setState(() {
        isFetching = true;
      });
      initializePosts();
    }

    if (posts == null || isFetching) {
      return const Center(child: CircularProgressIndicator());
    }

    return posts!.isNotEmpty
        ? ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: posts?.length ?? 0,
            itemBuilder: (context, index) {
              final Post p = posts![index];

              final String title = p.title.isEmpty ? "[No Title]" : p.title.titleCase;
              String? instruction = "No instruction";

              try {
                instruction = Document.fromJson(jsonDecode(p.instruction)).toPlainText();
              } catch (e) {
                if (kDebugMode) {
                  print(e);
                }
              }

              final bool isUpdated = p.createdAt! != p.updatedAt!;

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Theme.of(context).colorScheme.primary)),
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
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                DateFormat('h:mm a, dd/MM/yy (E)')
                                    .format(DateTime.parse(p.createdAt!)),
                                style: const TextStyle(fontSize: 12),
                              ),
                              if (isUpdated) ...[
                                const Text(
                                  " | ",
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                                const Text(
                                  "Edited on ",
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  DateFormat('h:mm a, dd/MM/yy (E)')
                                      .format(DateTime.parse(p.updatedAt!)),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                              const Text(
                                " | ",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                              const Text(
                                "Due on ",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                DateFormat('h:mm a, dd/MM/yy (E)').format(DateTime.parse(p.due)),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            title,
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  instruction!,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomButton(
                            type: CustomButtonType.primary,
                            startIcon: Icons.edit,
                            label: "Edit",
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TeacherEditPostPage(
                                        post: p, setPostToDirty: widget.setPostToDirty)))),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text(
                              p.points.toString(),
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const Text(" points"),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Duration: ",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(formatDurationToReadableDuration(p.duration)),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              );
            })
        : const TeacherNoPostPrompt();
  }
}
