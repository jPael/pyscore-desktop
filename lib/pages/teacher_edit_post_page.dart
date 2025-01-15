import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/custom_date_picker.dart';
import 'package:pyscore/components/custom_input.dart';
import 'package:pyscore/components/custom_timer_input.dart';
import 'package:pyscore/components/rich_text_editor.dart';
import 'package:pyscore/components/teacher_post_delete_button.dart';
import 'package:pyscore/constants/custom_button_type.dart';
import 'package:pyscore/constants/custom_input_type.dart';
import 'package:pyscore/constants/post_errors.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/utils/results.dart';
import 'package:pyscore/utils/utils.dart';

class TeacherEditPostPage extends StatefulWidget {
  const TeacherEditPostPage(
      {super.key, required this.post, required this.setPostToDirty});
  final Post post;
  final Function setPostToDirty;

  @override
  State<TeacherEditPostPage> createState() => _TeacherEditPostPageState();
}

class _TeacherEditPostPageState extends State<TeacherEditPostPage> {
  DateTime dueDate = DateTime.now();

  bool isLoading = false;
  bool hasError = false;
  String errorMsg = "";

  void handleChangeDate(DateTime date) {
    setState(() {
      dueDate = date;
    });
  }

  final GlobalKey<FormState> _key = GlobalKey();

  late TextEditingController titleController = TextEditingController();
  // late TextEditingController instructionsController = TextEditingController();
  late QuillController instructionsController = QuillController.basic();
  late TextEditingController pointsController = TextEditingController();
  late TextEditingController dueController = TextEditingController();

  // Timer

  late TextEditingController hoursController = TextEditingController();
  late TextEditingController minutesController = TextEditingController();
  late TextEditingController secondsController = TextEditingController();

  void insertDurationToDurationController(int duration) {
    // ignore: no_leading_underscores_for_local_identifiers
    int _d = duration;

    // ignore: no_leading_underscores_for_local_identifiers
    int _hours = (_d / (60 * 60)).floor();
    // int minutes = _d - (_hours * (60 * 60));
    _d -= (60 * 60 * _hours);
    // ignore: no_leading_underscores_for_local_identifiers
    int _minutes = (_d / 60).floor();
    _d -= _minutes * 60;
    // ignore: no_leading_underscores_for_local_identifiers
    int _seconds = _d;

    if (_hours > 0) {
      hoursController = TextEditingController(text: _hours.toString());
    } else {
      hoursController = TextEditingController();
    }
    if (_minutes > 0) {
      minutesController = TextEditingController(text: _minutes.toString());
    } else {
      minutesController = TextEditingController();
    }
    if (_seconds > 0) {
      secondsController = TextEditingController(text: _seconds.toString());
    } else {
      secondsController = TextEditingController();
    }
  }

  void handleSetPostToDirty() {
    widget.setPostToDirty();

    Navigator.pop(context);
  }

  void handlePost() async {
    setState(() {
      isLoading = true;
      hasError = false;
      errorMsg = "";
    });

    final int duration = getTimerDuration(
      hours: hoursController.text,
      minutes: minutesController.text,
      seconds: secondsController.text,
    );
    final int points =
        int.parse(pointsController.text.isEmpty ? "0" : pointsController.text);

    final String title = titleController.text;
    final String instructions =
        prettyJson(instructionsController.document.toDelta().toJson());
    final String due = dueDate.toString();

    Post p = Post(
      id: widget.post.id,
      classroomId: widget.post.classroomId!,
      title: title,
      instruction: instructions,
      points: points,
      duration: duration,
      due: due,
      createdAt: widget.post.createdAt,
    );

    PostResults result = await p.updatePost();

    if (!result.isSuccess) {
      setState(() {
        isLoading = false;
        hasError = true;
        errorMsg = PostErrors.error(result.code!);
      });
    } else {
      handleSetPostToDirty();
    }

    if (result.isSuccess && mounted) {
      setState(() {
        isLoading = false;
        hasError = false;
        errorMsg = "";
      });
      widget.setPostToDirty();
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    Post p = widget.post;

    titleController = TextEditingController(text: p.title);

    Document? instruction;

    try {
      instruction = Document.fromJson(jsonDecode(p.instruction));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    instructionsController.document = instruction ??
        Document.fromJson([
          {
            "insert": "Error",
            "attributes": {"bold": true, "color": "#FFFF0000"}
          },
          {"insert": ": Can't parse the data\n"},
          {
            "insert": "There was something wrong with  the data",
            "attributes": {"code": true}
          },
          {"insert": "\n\n"}
        ]);

    pointsController = TextEditingController(text: p.points.toString());
    dueController = TextEditingController(text: p.due);

    insertDurationToDurationController(p.duration);

    dueDate = DateTime.parse(p.due);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit post"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Row(
              children: [
                TeacherPostDeleteButton(
                    post: widget.post, setPostToDirty: handleSetPostToDirty)
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Form(
              key: _key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 200,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100,
                        child: CustomInput(
                            controller: pointsController,
                            hintText: "",
                            labelText: "Points",
                            formatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            length: 2,
                            inputType: InputType.number),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Due date:"),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(DateFormat("hh:mm a MMMM dd, yyyy")
                              .format(dueDate)),
                          const SizedBox(
                            width: 12,
                          ),
                          CustomDatePicker(
                              date: dueDate, handleChange: handleChangeDate),
                          const SizedBox(
                            width: 12,
                          ),
                          CustomTimerInput(
                            hoursController: hoursController,
                            minutesController: minutesController,
                            secondsController: secondsController,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomInput(
                    controller: titleController,
                    hintText: "",
                    labelText: "Title",
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  RichTextEditor(controller: instructionsController),
                  const SizedBox(
                    height: 12,
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
                        onTap: () => Navigator.pop(context),
                        type: CustomButtonType.ghost,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      CustomButton(label: "Save", onTap: handlePost),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
