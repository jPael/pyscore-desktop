import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pyscore/constants/custom_input_type.dart';

class CustomInput extends StatefulWidget {
  const CustomInput(
      {super.key,
      this.controller,
      required this.hintText,
      required this.labelText,
      this.isPassword = false,
      this.validator,
      this.minLine,
      this.maxLine = 1,
      this.enabled = true,
      this.inputType = InputType.text,
      this.formatters,
      this.length,
      this.size = InputSize.normal,
      this.value,
      this.readOnly = false,
      this.autoFocus = false});

  final TextEditingController? controller;
  final bool isPassword;
  final String hintText;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final int? minLine;
  final int? maxLine;
  final bool enabled;
  final InputType inputType;
  final List<TextInputFormatter>? formatters;
  final int? length;
  final InputSize? size;
  final String? value;
  final bool? readOnly;
  final bool autoFocus;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool hidePassword = false;

  void handleVisibilityToggle() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  TextInputType inputType(InputType type) {
    switch (type) {
      case InputType.text:
        return TextInputType.text;
      case InputType.number:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<InputSize, double> inputSize = {InputSize.sm: 12, InputSize.normal: 18, InputSize.lg: 26};

    final double inputFontSize = inputSize[widget.size]! + 0.0;

    return TextFormField(
        keyboardType: inputType(widget.inputType),
        maxLines: !widget.isPassword ? widget.maxLine : 1,
        minLines: !widget.isPassword ? widget.minLine : 1,
        obscureText: widget.isPassword && !hidePassword,
        autofocus: widget.autoFocus,
        enabled: widget.enabled,
        controller: widget.controller,
        initialValue: widget.value,
        inputFormatters: widget.formatters,
        readOnly: widget.readOnly!,
        maxLength: widget.length,
        decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            counterText: "",
            labelStyle: TextStyle(fontSize: inputFontSize),
            hintStyle: TextStyle(fontSize: inputFontSize),
            border: const OutlineInputBorder(),
            suffixIcon: widget.isPassword
                ? passwordVisibilityToggle(context, hidePassword, handleVisibilityToggle)
                : null),
        cursorHeight: inputFontSize + inputFontSize * 0.5,
        style: TextStyle(
          fontSize: inputFontSize,
        ),
        validator: widget.validator);
  }

  Widget passwordVisibilityToggle(BuildContext context, hidePassword, handleVisibilityToggle) {
    return IconButton(
        onPressed: handleVisibilityToggle,
        icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility));
  }
}
