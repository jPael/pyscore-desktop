import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pyscore/components/custom_input.dart';
import 'package:pyscore/constants/custom_input_type.dart';

class CustomTimerInput extends StatefulWidget {
  const CustomTimerInput(
      {super.key,
      required this.hoursController,
      required this.minutesController,
      required this.secondsController,
      this.defaultReadonly = true});

  final TextEditingController hoursController;
  final TextEditingController minutesController;
  final TextEditingController secondsController;
  final bool? defaultReadonly;

  @override
  CustomTimerInputState createState() => CustomTimerInputState();
}

class CustomTimerInputState extends State<CustomTimerInput> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = !widget.defaultReadonly!;
  }

  @override
  Widget build(BuildContext context) {
    const double inputWidth = 80.0;
    const InputSize size = InputSize.sm;

    return Row(
      mainAxisSize: MainAxisSize.min,
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
          width: inputWidth,
          child: CustomInput(
            enabled: isChecked,
            controller: widget.hoursController,
            hintText: "00",
            labelText: "Hour",
            formatters: [FilteringTextInputFormatter.digitsOnly],
            length: 2,
            inputType: InputType.number,
            size: size,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        SizedBox(
          width: inputWidth,
          child: CustomInput(
            enabled: isChecked,
            controller: widget.minutesController,
            hintText: "00",
            labelText: "Minute",
            formatters: [FilteringTextInputFormatter.digitsOnly],
            length: 2,
            inputType: InputType.number,
            size: size,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        SizedBox(
          width: inputWidth,
          child: CustomInput(
            enabled: isChecked,
            controller: widget.secondsController,
            hintText: "00",
            labelText: "Second",
            formatters: [FilteringTextInputFormatter.digitsOnly],
            length: 2,
            inputType: InputType.number,
            size: size,
          ),
        )
      ],
    );
  }
}
