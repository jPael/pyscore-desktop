import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/data/classroom_data.dart';
import 'package:pyscore/constants/types/custom_button_type.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/models/my_classrooms.dart';

class TeacherDeleteClassroomButton extends StatefulWidget {
  const TeacherDeleteClassroomButton({super.key, required this.classroom});

  final Classroom classroom;

  @override
  TeacherDeleteClassroomButtonState createState() => TeacherDeleteClassroomButtonState();
}

class TeacherDeleteClassroomButtonState extends State<TeacherDeleteClassroomButton> {
  Future<void> handleDelete() async {
    final String classroomId = widget.classroom.id!;

    await deleteClassroomById(classroomId);

    if (!mounted) return;

    context.read<MyClassrooms>().deleteClassroom(classroomId);

    Navigator.pop(context);
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check, color: Colors.black),
          const SizedBox(width: 12),
          Text(
            "Classroom ${widget.classroom.classroomName} deleted",
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
      duration: const Duration(seconds: 2),
      // change the bg color to green
      backgroundColor: Colors.greenAccent,
    ));
  }

  Future<void> showDeleteConfirmation(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                  "Are you sure you want to delete the classroom '${widget.classroom.classroomName}'?"),
              content: const Text("This can't be undone"),
              actions: [
                CustomButton(
                  label: "Delete",
                  onTap: handleDelete,
                  type: CustomButtonType.danger,
                ),
                CustomButton(
                  label: "Cancel",
                  onTap: () => Navigator.pop(context),
                  type: CustomButtonType.ghost,
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      startIcon: Icons.delete,
      type: CustomButtonType.danger,
      label: "Delete classroom",
      onTap: () => showDeleteConfirmation(context),
    );
  }
}
