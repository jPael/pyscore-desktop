import 'package:flutter/material.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/custom_input.dart';
import 'package:pyscore/components/error_card.dart';
import 'package:pyscore/constants/classroom_errors.dart';
import 'package:pyscore/models/my_classrooms.dart';
import 'package:pyscore/services/user_services.dart';
import 'package:pyscore/utils/results.dart';
import 'package:provider/provider.dart';

class JoinClassButton extends StatefulWidget {
  const JoinClassButton({super.key, required this.userId});

  final String userId;

  @override
  JoinClassButtonState createState() => JoinClassButtonState();
}

class JoinClassButtonState extends State<JoinClassButton> {
  bool hasError = false;
  bool isLoading = false;
  String errorMsg = "";

  final TextEditingController codeController = TextEditingController();

  Future<void> showJoinClassDialog(BuildContext context) => showDialog(
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
          builder: (context, setState) => Dialog(
                child: SizedBox(
                  width: 500,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Join class",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Divider(color: (Theme.of(context).colorScheme.primary.withOpacity(0.5))),
                        const SizedBox(
                          height: 12,
                        ),
                        if (hasError) ErrorCard(errorMsg: errorMsg),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text("Enter the class code"),
                        const SizedBox(
                          height: 6,
                        ),
                        SizedBox(
                          width: 200,
                          child: CustomInput(
                              controller: codeController, hintText: "", labelText: "Code"),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        const Text(
                          "Ask for the class code if you do not the code.",
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomButton(
                              isLoading: isLoading,
                              label: "Join",
                              onTap: () async {
                                setState(() {
                                  isLoading = true;
                                });

                                String classroomCode = codeController.text;

                                ClassroomResults result =
                                    await joinClass(widget.userId, classroomCode);

                                print(result.isSuccess);

                                if (!result.isSuccess) {
                                  setState(() {
                                    hasError = true;
                                    isLoading = false;
                                    errorMsg = ClassroomErrors.error(result.error!);
                                  });
                                  return;
                                }

                                if (context.mounted) {
                                  context.read<MyClassrooms>().refetchData();
                                  Navigator.pop(context);
                                }

                                setState(() {
                                  hasError = false;
                                  isLoading = false;
                                  errorMsg = "";
                                });
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )));

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [CustomButton(label: "Join class", onTap: () => showJoinClassDialog(context))],
    );
  }
}
