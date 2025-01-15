import 'package:flutter/material.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/constants/post_errors.dart';
import 'package:pyscore/data/post_data.dart';
import 'package:pyscore/constants/custom_button_type.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/utils/results.dart';

class TeacherPostDeleteButton extends StatefulWidget {
  const TeacherPostDeleteButton(
      {super.key, required this.post, required this.setPostToDirty});
  final Post post;
  final Function setPostToDirty;
  @override
  TeacherPostDeleteButtonState createState() => TeacherPostDeleteButtonState();
}

class TeacherPostDeleteButtonState extends State<TeacherPostDeleteButton> {
  bool hasError = false;
  bool isSuccess = false;
  bool isLoading = false;
  String? errorMsg;

  Future<void> handleDelete(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    PostResults result = await deletePostById(widget.post.id!);

    if (context.mounted && result.isSuccess) {
      Navigator.pop(context);
      widget.setPostToDirty();
    }

    setState(() {
      isLoading = false;

      if (!result.success!) {
        hasError = !result.success!;
        errorMsg = PostErrors.error(result.code!);
      }

      isLoading = false;
    });
  }

  Future<void> showDeleteWarning() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Delete this post",
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          if (hasError)
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.red[100],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.red)),
                              child: Row(
                                children: [
                                  Text(
                                    "Error: ",
                                    style: TextStyle(
                                        color: Colors.red[800],
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    errorMsg!,
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            widget.post.title,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.warning_rounded,
                                color: Colors.redAccent,
                              ),
                              Text(
                                "Warning: ",
                                style: TextStyle(color: Colors.red[700]),
                              ),
                              const Text(
                                "This can't be undone",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomButton(
                                  label: "Cancel",
                                  onTap: () => Navigator.pop(context)),
                              const SizedBox(
                                width: 12,
                              ),
                              CustomButton(
                                  type: CustomButtonType.danger,
                                  label: "Delete",
                                  isLoading: isLoading,
                                  onTap: () async =>
                                      await handleDelete(context)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (hasError == false && isSuccess == true) {
      Navigator.pop(context);
    }

    return Row(
      children: [
        CustomButton(
            isLoading: isLoading,
            type: CustomButtonType.danger,
            startIcon: Icons.delete,
            label: "Delete",
            onTap: showDeleteWarning),
      ],
    );
  }
}
