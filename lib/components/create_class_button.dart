import 'package:flutter/material.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/custom_input.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/models/my_classrooms.dart';
import 'package:provider/provider.dart';

class CreateClassButton extends StatefulWidget {
  const CreateClassButton({super.key});

  @override
  _CreateClassButtonState createState() => _CreateClassButtonState();
}

class _CreateClassButtonState extends State<CreateClassButton> {
  final TextEditingController classroomNameController = TextEditingController();

  final TextEditingController sectionController = TextEditingController();

  void handleCreateClassroom() {
    final String id = classroomNameController.text;
    final String cName = classroomNameController.text;
    final String section = sectionController.text;
    const String owner = "Daisy Matlih";

    MyClassrooms myClassroom;
    Classroom classroom = Classroom(id, cName, section, owner, []);

    Navigator.pop(context);

    context.read<MyClassrooms>().createClassroom(classroom);
  }

  Future<void> showCreateClassroomDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Row(
                      children: [
                        Text(
                          "Create a class",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomInput(
                        controller: classroomNameController,
                        hintText: "",
                        labelText: "Name"),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomInput(
                        controller: sectionController,
                        hintText: "",
                        labelText: "Section"),
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
                          type: "ghost",
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        CustomButton(
                          label: "Create",
                          onTap: () => handleCreateClassroom(),
                          type: "primary",
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    classroomNameController.dispose();
    sectionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        label: "Create class", onTap: () => showCreateClassroomDialog(context));
  }
}
