import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/custom_date_picker.dart';
import 'package:pyscore/components/custom_input.dart';
import 'package:pyscore/components/custom_timer_input.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/models/my_classrooms.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/utils/results.dart';

class TeacherCreatePost extends StatefulWidget {
  const TeacherCreatePost(
      {super.key, required this.classroom, required this.initializePosts});

  final Classroom classroom;
  final Function initializePosts;

  @override
  TeacherCreatePostState createState() => TeacherCreatePostState();
}

class TeacherCreatePostState extends State<TeacherCreatePost> {
  final GlobalKey<FormState> _key = GlobalKey();

  DateTime dueDate = DateTime.now();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();
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

  int getTimerDuration() {
    final int hours =
        int.parse(hoursController.text.isEmpty ? "0" : hoursController.text);
    final int minutes = int.parse(
        minutesController.text.isEmpty ? "0" : minutesController.text);
    final int seconds = int.parse(
        secondsController.text.isEmpty ? "0" : secondsController.text);

    return (hours * 60 * 60) + (minutes * 60) + seconds;
  }

  void handlePost() async {
    final int duration = getTimerDuration();
    final int points =
        int.parse(pointsController.text.isEmpty ? "0" : pointsController.text);

    final String title = titleController.text;
    final String instructions = instructionsController.text;
    final String due = dueDate.toString();

    Post p = Post(
        classroomId: widget.classroom.id,
        title: title,
        instruction: instructions,
        points: points,
        duration: duration,
        due: due);

    PostResults result = await p.insertToDb();

    if (result.isSuccess && mounted) {
      context.read<MyClassrooms>().createPost(widget.classroom, p);
      Navigator.pop(context);
      widget.initializePosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Create post to "),
            Text(
              widget.classroom.classroomName,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
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
                mainAxisSize: MainAxisSize.min,
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
                    maxLine: 6,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomTimerInput(
                    hoursController: hoursController,
                    minutesController: minutesController,
                    secondsController: secondsController,
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
