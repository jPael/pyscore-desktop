import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pyscore/components/custom_input.dart';

class CustomTimerInput extends StatefulWidget {
  const CustomTimerInput(
      {super.key,
      required this.hoursController,
      required this.minutesController,
      required this.secondsController});

  final TextEditingController hoursController;
  final TextEditingController minutesController;
  final TextEditingController secondsController;

  @override
  CustomTimerInputState createState() => CustomTimerInputState();
}

class CustomTimerInputState extends State<CustomTimerInput> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: isChecked,
            onChanged: (v) {
              setState(
                () {
                  isChecked = v!;
                },
              );
            }),
        const Text("Timer: "),
        const SizedBox(
          width: 12,
        ),
        SizedBox(
          width: 100,
          child: CustomInput(
            enabled: isChecked,
            controller: widget.hoursController,
            hintText: "00",
            labelText: "Hour",
            formatters: [FilteringTextInputFormatter.digitsOnly],
            length: 2,
            inputType: InputType.number,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        SizedBox(
          width: 100,
          child: CustomInput(
              enabled: isChecked,
              controller: widget.minutesController,
              hintText: "00",
              labelText: "Minute",
              formatters: [FilteringTextInputFormatter.digitsOnly],
              length: 2,
              inputType: InputType.number),
        ),
        const SizedBox(
          width: 12,
        ),
        SizedBox(
          width: 100,
          child: CustomInput(
              enabled: isChecked,
              controller: widget.secondsController,
              hintText: "00",
              labelText: "Second",
              formatters: [FilteringTextInputFormatter.digitsOnly],
              length: 2,
              inputType: InputType.number),
        )
      ],
    );
  }
}
