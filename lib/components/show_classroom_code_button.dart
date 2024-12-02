import 'package:flutter/material.dart';
import 'package:pyscore/components/custom_button.dart';

class ShowClassroomCodeButton extends StatefulWidget {
  const ShowClassroomCodeButton({super.key, required this.code});

  final String code;

  @override
  ShowClassroomCodeButtonState createState() => ShowClassroomCodeButtonState();
}

class ShowClassroomCodeButtonState extends State<ShowClassroomCodeButton> {
  Future<void> showClassroomCode(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Class code",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      widget.code,
                      style: const TextStyle(fontSize: 32),
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        startIcon: Icons.pin,
        label: "Show code",
        onTap: () => showClassroomCode(context));
  }
}
