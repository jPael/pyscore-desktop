import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/custom_date_picker.dart';
import 'package:pyscore/components/custom_input.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/models/my_classrooms.dart';
import 'package:pyscore/models/posts.dart';
import 'package:provider/provider.dart';

class TeacherCreatePost extends StatefulWidget {
  const TeacherCreatePost({super.key, required this.classroom});

  final Classroom classroom;

  @override
  _TeacherCreatePostState createState() => _TeacherCreatePostState();
}

class _TeacherCreatePostState extends State<TeacherCreatePost> {
  GlobalKey<FormState> _key = GlobalKey();

  DateTime dueDate = DateTime.now();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();
  final TextEditingController pointsController = TextEditingController();
  final TextEditingController dueController = TextEditingController();

  void handleChangeDate(DateTime date) {
    setState(() {
      dueDate = date;
    });
  }

  void handlePost() {
    const String id = "someID";
    final String title = titleController.text;
    final String instructions = instructionsController.text;
    final String points = pointsController.text;
    final String due = dueDate.toString();

    Posts p = Posts(id, title, instructions, points, due);
    context.read<MyClassrooms>().createPost(widget.classroom, p);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: CustomInput(
                        controller: pointsController,
                        hintText: "",
                        labelText: "Points"),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomInput(
                      controller: titleController,
                      hintText: "",
                      labelText: "Title"),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomInput(
                    controller: instructionsController,
                    hintText: "",
                    labelText: "Instructions",
                    minLine: 5,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const Text("Due date:"),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(DateFormat("hh:mm a MMMM dd, yyyy").format(dueDate)),
                      const SizedBox(
                        width: 12,
                      ),
                      CustomDatePicker(
                          date: dueDate, handleChange: handleChangeDate),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        label: "Cancel",
                        onTap: () => Navigator.pop(context),
                        type: "ghost",
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      CustomButton(label: "Post", onTap: handlePost),
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
