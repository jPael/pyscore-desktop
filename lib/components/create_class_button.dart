import 'package:flutter/material.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/custom_input.dart';
import 'package:pyscore/constants/errors/classroom_errors.dart';
import 'package:pyscore/constants/types/custom_button_type.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/models/my_classrooms.dart';
import 'package:provider/provider.dart';
import 'package:pyscore/models/user.dart';
import 'package:pyscore/utils/results.dart';

class CreateClassButton extends StatefulWidget {
  const CreateClassButton({
    super.key,
    required this.user,
  });

  final User user;

  @override
  CreateClassButtonState createState() => CreateClassButtonState();
}

class CreateClassButtonState extends State<CreateClassButton> {
  bool hasError = false;
  String? errorMessage;

  final TextEditingController classroomNameController = TextEditingController();

  final TextEditingController sectionController = TextEditingController();

  void handleCreateClassroom() async {
    final String name = classroomNameController.text;

    if (name.isEmpty) return;

    Classroom classroom = Classroom(
      classroomName: name,
      owner: widget.user,
    );

    Navigator.pop(context);

    ClassroomResults res = await classroom.insertToDb(widget.user.id!);

    if (res.isSuccess && mounted) {
      setState(() {
        hasError = false;
        errorMessage = null;
      });
      context.read<MyClassrooms>().createClassroom(classroom);
    } else {
      setState(() {
        hasError = true;
        errorMessage = ClassroomErrors.error(res.error!);
      });
    }
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
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
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
                        controller: classroomNameController, hintText: "", labelText: "Name"),
                    const SizedBox(
                      height: 12,
                    ),
                    if (hasError)
                      Row(
                        children: [
                          const Text(
                            "Error:",
                            style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            errorMessage ?? "",
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                        ],
                      ),
                    // CustomInput(
                    //     controller: sectionController,
                    //     hintText: "",
                    //     labelText: "Section"),
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
                        CustomButton(
                          label: "Create",
                          onTap: () => handleCreateClassroom(),
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
    return CustomButton(label: "Create class", onTap: () => showCreateClassroomDialog(context));
  }
}
