import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:provider/provider.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/custom_date_picker.dart';
import 'package:pyscore/components/custom_input.dart';
import 'package:pyscore/components/custom_timer_input.dart';
import 'package:pyscore/components/error_card.dart';
import 'package:pyscore/components/rich_text_editor.dart';
import 'package:pyscore/constants/custom_input_type.dart';
import 'package:pyscore/constants/post_errors.dart';
import 'package:pyscore/constants/custom_button_type.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/models/my_classrooms.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/utils/results.dart';
import 'package:pyscore/utils/utils.dart';

class TeacherCreatePost extends StatefulWidget {
  const TeacherCreatePost({
    super.key,
    required this.classroom,
    required this.setPostToDirty,
  });

  final Classroom classroom;
  final Function setPostToDirty;

  @override
  TeacherCreatePostState createState() => TeacherCreatePostState();
}

class TeacherCreatePostState extends State<TeacherCreatePost> {
  final GlobalKey<FormState> _key = GlobalKey();

  DateTime dueDate = DateTime.now();
  bool isLoading = false;
  bool hasError = false;
  String errorMsg = "";

  final TextEditingController titleController = TextEditingController();
  // final TextEditingController instructionsController = TextEditingController();
  final QuillController instructionsController = QuillController.basic();

  final TextEditingController pointsController = TextEditingController();
  final TextEditingController dueController = TextEditingController();

  // Timer

  final TextEditingController hoursController = TextEditingController();
  final TextEditingController minutesController = TextEditingController();
  final TextEditingController secondsController = TextEditingController();

  void handleChangeDate(DateTime date) {
    setState(() {
      dueDate = date;
    });
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
        seconds: secondsController.text);

    final int points =
        int.parse(pointsController.text.isEmpty ? "0" : pointsController.text);

    final String title = titleController.text;
    final String instructions =
        prettyJson(instructionsController.document.toDelta().toJson());
    final String due = dueDate.toString();

    Post p = Post(
        classroomId: widget.classroom.id,
        title: title,
        instruction: instructions,
        points: points,
        duration: duration,
        due: due);

    PostResults result = await p.insertToDb();

    if (!result.isSuccess) {
      setState(() {
        isLoading = false;
        hasError = true;
        errorMsg = PostErrors.error(result.code!);
      });
    }

    if (result.isSuccess && mounted) {
      setState(() {
        isLoading = false;
        hasError = false;
        errorMsg = "";
      });
      context.read<MyClassrooms>().createPost(widget.classroom, p);
      widget.setPostToDirty();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text("Create post to "),
            Text(
              widget.classroom.classroomName,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  if (hasError) ErrorCard(errorMsg: errorMsg),
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
                      CustomButton(
                          isLoading: isLoading,
                          label: "Post",
                          onTap: handlePost),
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
