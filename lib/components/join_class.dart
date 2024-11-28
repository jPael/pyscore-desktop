import 'package:flutter/material.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/custom_input.dart';

class JoinClass extends StatefulWidget {
  const JoinClass({super.key});

  @override
  JoinClassState createState() => JoinClassState();
}

class JoinClassState extends State<JoinClass> {
  final TextEditingController codeController = TextEditingController();

  Future<void> showJoinClassDialog(BuildContext context) => showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
            child: SizedBox(
              width: 500,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
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
                    Divider(
                        color: (Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5))),
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
                          controller: codeController,
                          hintText: "",
                          labelText: "Code"),
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
                          label: "Join",
                          onTap: () {},
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ));

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomButton(
            label: "Join class", onTap: () => showJoinClassDialog(context))
      ],
    );
  }
}
